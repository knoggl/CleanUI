//
//  WebView.swift
//  CleanUI
//
//  Created by Julian Gerhards on 05.10.21.
//

import SwiftUI
import WebKit

/// Webview is a UIViewRepresentable for an WKWebView
struct Webview: UIViewRepresentable {
    
    var url: URL
    @Binding var title: String
    @Binding var currentUrl: String
    
    /// - Parameters:
    ///   - url: The url that should be accessed
    ///   - title: The title of the current web page
    ///   - currentUrl: The url of the current web page
    init(_ url: URL, title: Binding<String>, currentUrl: Binding<String>) {
        self.url = url
        self._title = title
        self._currentUrl = currentUrl
    }
    
    let webview = WKWebView()
    
    func makeUIView(context: Context) -> WKWebView {
        webview.navigationDelegate = context.coordinator
        webview.allowsLinkPreview = true
        webview.allowsBackForwardNavigationGestures = true
        webview.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.title), options: .new, context: nil)
        webview.addObserver(context.coordinator, forKeyPath: #keyPath(WKWebView.url), options: .new, context: nil)
        
        if(!url.absoluteString.lowercased().starts(with: String("https://")) && !url.absoluteString.lowercased().starts(with: String("http://"))){
            let request = URLRequest(url: URL(string: "http://" + url.absoluteString)!)
            webview.load(request)
        }else {
            let request = URLRequest(url: url)
            webview.load(request)
        }
        
        return webview
    }
    
    func updateUIView(_ webview: WKWebView, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate {
        var parent: Webview
        
        init(_ webView: Webview) {
            self.parent = webView
        }
        
        override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
            if keyPath == "title" {
                withAnimation {
                    self.parent.title = parent.webview.title ?? "Browser"
                }
            }else if keyPath == "url" {
                withAnimation {
                    do {
                        self.parent.currentUrl = try String(contentsOf: parent.webview.url!)
                    }catch{}
                }
            }
        }
    }
}
