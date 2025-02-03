//
//  VideoPlayerView.swift
//  APODBox
//
//  Created by Denis Couras on 30/01/25.
//

import UIKit
import WebKit

final class VideoPlayerView: UIView {
    private var webView: WKWebView?

    init() {
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Public methods
    func configure(url: URL) {
        setupPlayerLayer(url: url)
    }

    // MARK: - Private Methods
    private func setupPlayerLayer(url: URL) {
        let configuration = WKWebViewConfiguration()
        let webpagePreferences = WKWebpagePreferences()
        webpagePreferences.allowsContentJavaScript = true
        configuration.defaultWebpagePreferences = webpagePreferences
        webView = WKWebView(frame: bounds, configuration: configuration)
        addSubview(webView!)
        webView?.load(URLRequest(url: url))
    }
}
