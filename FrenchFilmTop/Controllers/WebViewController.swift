//
//  WebViewController.swift
//  FrenchFilmTop
//
//  Created by ineta.magone on 22/11/2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {

    var netflix = String()
    var amazon = String()
    var itunes = String()
    var hulu = String()
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Web"
        
        guard let url = URL(string: netflix) else {return}
        webView.load(URLRequest(url: url))
        
        guard let url = URL(string: amazon) else {return}
        webView.load(URLRequest(url: url))
        
        guard let url = URL(string: itunes) else {return}
        webView.load(URLRequest(url: url))
        
        guard let url = URL(string: hulu) else {return}
        webView.load(URLRequest(url: url))
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        print("didFinish navigation")
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("didStartProvisionalNavigation")
    }
}
