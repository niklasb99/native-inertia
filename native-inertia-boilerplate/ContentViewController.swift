//
//  ContentViewController.swift
//  native-inertia-boilerplate
//
//  Created by Mario Hamann on 03.05.23.
//

import Foundation
import SwiftUI
import WebKit

class ContentViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create the web view
        let webView = WKWebView(frame: .zero)
        view = Inertia.setup(webView: webView, router: AppRouter(webView:webView))
    }
}
