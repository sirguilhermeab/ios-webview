import UIKit
import WebKit
class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler {
    
    var webView: WKWebView?
    var webConfig:WKWebViewConfiguration {
        get {
            webView!.configuration.preferences.setValue(true, forKey: "developerExtrasEnabled")

            let webCfg:WKWebViewConfiguration = WKWebViewConfiguration()

            webCfg.preferences.setValue(true, forKey: "developerExtrasEnabled") // Enable remote inspection

            let userController:WKUserContentController = WKUserContentController()
            userController.add(self, name: "submit")
            let js:String = buttonClickEventTriggered()
            let userScript:WKUserScript =  WKUserScript(source: js, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: false)
            userController.addUserScript(userScript)
            webCfg.userContentController = userController;
            return webCfg;
        }
    }
    
    override func loadView() {
        
        
        
        
        
        
        
        
        
        
        
        
        
        
        let webConfiguration = WKWebViewConfiguration()

        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView?.uiDelegate = self
        if #available(iOS 16.4, *) {
            webView?.isInspectable = true
        } else {
            // Fallback on earlier versions
        }
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        super.viewDidLoad()
            self.webView = WKWebView(frame: self.view.frame, configuration: webConfig)
        
        if #available(iOS 16.4, *) {
            webView?.isInspectable = true
        } else {
            // Fallback on earlier versions
        }
            self.webView!.navigationDelegate = self
            self.view = webView!
            let url = URL(string:"https://www.c-sharpcorner.com")
            let req = NSURLRequest(url:url! as URL)
            self.webView!.load(req as URLRequest)
            }
 
    func buttonClickEventTriggered() ->String{
        let script:String = "document.getElementById('PageBody').addEventListener('click', function () {window.webkit.messageHandlers.submit.postMessage('submited');});"//Make sure you have mapped the name correctly under userController.add
        return script;
    }

    @objc(userContentController:didReceiveScriptMessage:) func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        print("Sucessss")
        if(message.name == "submit") {
            print("It does ! \(message.body)")
            // Your code goes here
        }
    }
}

