//
//  ViewController.swift
//  SampleWebView
//
//  Created by prolifics on 30/03/23.
//

import UIKit
import WebKit

public class DGWebView: UIViewController {
    var webView = WKWebView()
    var token = ""
    var frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    var vc:  UIViewController?
    
    public init(token: String) {
        self.token = token
        super.init(nibName: nil, bundle: nil)
        DispatchQueue.global(qos: .background).async {
            self.addWebView()
            
        }
    }

        required init?(coder aDecoder: NSCoder) {
            fatalError("Storyboard are a pain")
        }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .yellow
        DispatchQueue.global(qos: .background).async {
            self.addWebView()

               }
    }
    
    private func addWebView(){
        let preferences = WKPreferences()
       // preferences.javaScriptEnabled = true
        preferences.javaScriptCanOpenWindowsAutomatically = true
        
        let cookie = HTTPCookie(properties: [
            .domain: ".fedway.com",
            .path: "/",
            .name: "LtpaToken2",
            .value: self.token,
            .expires: NSDate(timeIntervalSinceNow: 3600)
        ])
        
        if let myCookie = cookie {
            WKWebViewConfiguration.includeCookie(cookie: myCookie, preferences: preferences) { config in
                if let configuratiion  = config {
                   self.webView = WKWebView(frame: self.frame, configuration: configuratiion)
                    self.view.addSubview(self.webView)
                    let url = URL(string: "https://www.fedway.com/wps/myportal/hidden/mobi/pwshipment")
                    let request = URLRequest(url: url!)
                    self.webView.load(request)
                    
                }
            }
        }
   
    }
}

extension WKWebViewConfiguration {
        
    static func includeCookie(cookie:HTTPCookie, preferences:WKPreferences, completion: @escaping (WKWebViewConfiguration?) -> Void) {
        DispatchQueue.main.async {
            
            let config = WKWebViewConfiguration()
            config.preferences = preferences
            
            let dataStore = WKWebsiteDataStore.nonPersistent()
            
            DispatchQueue.main.async {
                let waitGroup = DispatchGroup()
                
                waitGroup.enter()
                dataStore.httpCookieStore.setCookie(cookie) {
                    waitGroup.leave()
                }
                
                waitGroup.notify(queue: DispatchQueue.main) {
                    config.websiteDataStore = dataStore
                    completion(config)
                }
            }
        }
    }

    }
