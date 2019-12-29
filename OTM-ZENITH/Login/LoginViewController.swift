//
//  LoginViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import OAuthSwift
import AuthenticationServices
import Prephirences

class LoginViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var password: UITextField!
    @IBOutlet var loginButton: UIButton!
    
    lazy var internalWebViewController: WebViewController = {
        let controller = WebViewController()
        controller.view = UIView(frame: UIScreen.main.bounds) // needed if no nib or not loaded from storyboard
        controller.delegate = self
        controller.viewDidLoad() // allow WebViewController to use this ViewController as parent to be presented
        return controller
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.layer.cornerRadius = 8
        loginButton.clipsToBounds = true
        loginButton.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if UserDefaults.standard.bool(forKey: "FirstLaunch") != true {
            
            // Clear existing login credentials
            KeychainPreferences.sharedInstance["credential"] = nil
            
            
            UserDefaults.standard.set(true, forKey: "FirstLaunch")
        }
        
        if !APIClient.oauthClient.client.credential.oauthToken.isEmpty  {
            navigateToHome()
        }
        else {
            loginButton.isHidden = false
        }
    }

    @IBAction func login(_ sender: Any) {
        print("Login Clicked")
        
        let oauthswift = APIClient.oauthClient
        
        oauthswift.authorizeURLHandler = getURLHandler()
//        oauthswift.authorizeURLHandler = ASWebAuthenticationURLHandler(callbackUrlScheme: "otm-zenith://oauth-callback/jira", presentationContextProvider: self)
//        oauthswift.authorizeURLHandler = SafariURLHandler(viewController: self, oauthSwift: oauthswift)
        
        APIClient().login { (result) in
            self.navigateToHome()
        }
    }

    
    func getURLHandler() -> OAuthSwiftURLHandlerType {
        if self.internalWebViewController.parent == nil {
//            self.show(internalWebViewController, sender: nil)
            self.addChild(self.internalWebViewController)
        }
        return internalWebViewController
    }
    
    func navigateToHome() {
        let homeVC = UIStoryboard(name: "JobList", bundle: nil).instantiateInitialViewController()!
        
        navigationController?.setViewControllers([homeVC], animated: false)
    }
    
}

extension LoginViewController: OAuthWebViewControllerDelegate {
    
    func oauthWebViewControllerDidPresent() {
        
    }
    func oauthWebViewControllerDidDismiss() {
        
    }
    
    func oauthWebViewControllerWillAppear() {
        
    }
    func oauthWebViewControllerDidAppear() {
        
    }
    func oauthWebViewControllerWillDisappear() {
        
    }
    func oauthWebViewControllerDidDisappear() {
        // Ensure all listeners are removed if presented web view close
        APIClient.oauthClient.cancel()
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.topWindow ?? view.window ?? ASPresentationAnchor()
    }
}
