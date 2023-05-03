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

public class InertiaRequest {

  public let route: InertiaRoute

  public var urlParams = [String: String]()
  public var queryParams = [String: String]()
  public var data: [String: Any]
  public var method: String
  public var url: URL

  init(
    aRoute: InertiaRoute,
    urlParams: [URLQueryItem],
    queryParams: [URLQueryItem]?,
    data: [String: Any],
    method: String,
    url: URL
  ) {
    route = aRoute
    for param in urlParams {
      if let value = param.value {
        self.urlParams[param.name] = value
      }
    }

    if let queryParams = queryParams {
      for param in queryParams {
        if let value = param.value {
          self.queryParams[param.name] = value
        }
      }
    }

    self.data = data
    self.method = method
    self.url = url
  }

  /**
        Acessing url params in the route, ie. id from /video/:id

        - parameter name: Key of the param
        - returns: value of the the param
    */
  public func param(_ name: String) -> String? {
    return urlParams[name]
  }

  /**
        Acessing query strings params in the route, ie q from /video?q=asdf

        - parameter name: Key of the param
        - returns: value of the the param
    */
  public func query(_ name: String) -> String? {
    return queryParams[name]
  }

}
