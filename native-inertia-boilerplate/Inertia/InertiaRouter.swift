////////////////////////////////////////////////////////////////////////////
// Copyright 2015 Viacom Inc.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//
// Modifications under MIT License
//
////////////////////////////////////////////////////////////////////////////
import Foundation
import SwiftyJSON
import WebKit

public typealias InertiaRouteHandler = (_ req: InertiaRequest) -> String

public class InertiaRouter: NSObject, WKScriptMessageHandler {

  var routesByMethod: [String: [InertiaRoute: InertiaRouteHandler]] = [:]

  /// Reference to the web view
  var webView: WKWebView

  public init(webView: WKWebView) {
    self.webView = webView
  }

  public func serve(response: String) {
    self.webView.evaluateJavaScript(response)
  }

  /**
        Handles incoming requests from the web view
    */
  public func userContentController(
    _ userContentController: WKUserContentController, didReceive message: WKScriptMessage
  ) {
    if message.name != "native-inertia" { return }

    self.setRoutes()

    // Here is our "listener" for requests
    self.handleRequestFromWebvie(message: message)
  }

  private func handleRequestFromWebvie(message: WKScriptMessage) {
    let request = JSON(Data((message.body as! String).utf8))
    let method = request["method"].stringValue
    let data = request["data"].dictionaryObject!

    let originalURL = request["url"].stringValue
    // Replace the base with the new base URL
    let url = URL(
      string: originalURL.replacingOccurrences(
        of: "http://localhost:5173/", with: "inertiaroute://")
    )!

    self.match(method, url, data)
  }

  public func setRoutes() {
  }

  /**
        Binds a get route to a router

        - parameter aRoute: A string reprsentation of the route. It can include url params, for example id in /video/:id
        - parameter callback: Triggered when a route is matched
    */

  public func get(_ aRoute: String, callback: @escaping InertiaRouteHandler) {
    self.bind(aRoute, callback: callback, method: "get")
  }

  /**
        Binds a post route to a router

        - parameter aRoute: A string reprsentation of the route. It can include url params, for example id in /video/:id
        - parameter callback: Triggered when a route is matched
    */

  public func post(_ aRoute: String, callback: @escaping InertiaRouteHandler) {
    self.bind(aRoute, callback: callback, method: "post")
  }

  /**
        Binds a put route to a router

        - parameter aRoute: A string reprsentation of the route. It can include url params, for example id in /video/:id
        - parameter callback: Triggered when a route is matched
    */

  public func put(_ aRoute: String, callback: @escaping InertiaRouteHandler) {
    self.bind(aRoute, callback: callback, method: "put")
  }

  /**
        Binds a patch route to a router

        - parameter aRoute: A string reprsentation of the route. It can include url params, for example id in /video/:id
        - parameter callback: Triggered when a route is matched
    */

  public func patch(_ aRoute: String, callback: @escaping InertiaRouteHandler) {
    self.bind(aRoute, callback: callback, method: "patch")
  }

  /**
        Binds a delete route to a router

        - parameter aRoute: A string reprsentation of the route. It can include url params, for example id in /video/:id
        - parameter callback: Triggered when a route is matched
    */

  public func delete(_ aRoute: String, callback: @escaping InertiaRouteHandler) {
    self.bind(aRoute, callback: callback, method: "delete")
  }

  /**
        Binds a route to a router

        - parameter aRoute: A string reprsentation of the route. It can include url params, for example id in /video/:id
        - parameter callback: Triggered when a route is matched

        When a route is bound using the bind method, it is added to the dictionary for the appropriate HTTP method.
        If a dictionary already exists for the method, the route and its corresponding handler are added to it.
        Otherwise, a new dictionary is created with the route and its handler.
    */
  public func bind(_ aRoute: String, callback: @escaping InertiaRouteHandler, method: String) {
    do {
      let route = try InertiaRoute(aRoute: aRoute)

      // add route to dictionary
      if var routes = routesByMethod[method] {
        routes[route] = { req -> String in
          let response = callback(req)
          self.serve(response: response)
          return response
        }
        routesByMethod[method] = routes
      } else {
        routesByMethod[method] = [
          route: { req -> String in
            let response = callback(req)
            self.serve(response: response)
            return response
          }
        ]
      }
    } catch let error as InertiaRoute.RegexResult {
      print(error.debugDescription)
    } catch {
      fatalError("[\(aRoute)] unknown bind error")
    }
  }

  /**
        Matches an incoming NSURL to a route present in the router. Returns nil if none are matched.

        - parameter url: An NSURL of an incoming request to the router
        - returns: The matched route or nil
    */
  @discardableResult
  public func match(_ method: String, _ url: URL, _ data: [String: Any]) -> InertiaRoute? {
    // Fix a problem with the URL contains Chinese
    guard
      let url = URL(
        string: (url.relativeString.removingPercentEncoding?
          .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)) ?? "")
    else {
      return nil
    }

    guard let routeComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
      return nil
    }

    // form the host/path url
    let host = routeComponents.host.flatMap({ "/\($0)" }) ?? ""
    let path = routeComponents.path
    let routeToMatch = "\(host)\(path)"
    let queryParams = routeComponents.queryItems
    var urlParams = [URLQueryItem]()

    // get routes for the method
    guard let routes = routesByMethod[method] else {
      return nil
    }

    // match the route!
    for route in routes.keys {
      guard let pattern = route.routePattern,
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
      else {
        continue
      }

      let matches = regex.matches(
        in: routeToMatch, options: [],
        range: NSMakeRange(0, routeToMatch.count))

      // check if routeToMatch has matched
      if matches.count > 0 {
        let match = matches[0]

        // gather url params
        for i in 1..<match.numberOfRanges {
          let name = route.urlParamKeys[i - 1]
          let range = match.range(at: i)
          let value = (routeToMatch as NSString).substring(with: range)
          urlParams.append(URLQueryItem(name: name, value: value))
        }

        // fire callback
        if let callback = routes[route] {
          callback(
            InertiaRequest(
              aRoute: route, urlParams: urlParams, queryParams: queryParams, data: data,
              method: method, url: url))
        }

        // return route that was matched
        return route
      }
    }

    // nothing matched
    return nil
  }

}
