//
//  AppDelegate.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import OAuthSwift
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation: UINavigationController?
    let service = IssueService()
    var launchoption : [UIApplication.LaunchOptionsKey: Any]?
    
    func sharedAppDelegate() -> AppDelegate {
       return UIApplication.shared.delegate as! AppDelegate
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        

        self.launchoption = launchOptions
		IQKeyboardManager.shared.enable = true
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func application(_ application: UIApplication, handleOpen url: URL) -> Bool {
        return true
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        /*guard let url = self.launchoption?.urlContexts.first?.url else { return }
        if (url.host == "url=https"){
            if !APIClient.oauthClient.client.credential.oauthToken.isEmpty  {
                if let lastcomponent = url.absoluteString.components(separatedBy: "=").last {
                    if let url = URL(string: lastcomponent) {
                        self.service.fetchIssue(issueId: url.lastPathComponent) { (issue) in
                            let homeVC = UIStoryboard(name: "JobList", bundle: nil).instantiateInitialViewController()! as! JobListViewController
                            let jobdetailvc = UIStoryboard(name: "Job", bundle:nil).instantiateViewController(withIdentifier: "JobViewController") as! JobViewController
                            jobdetailvc.viewModel = JobViewModel(issue: issue)
                            let nav = UINavigationController()
                            nav.viewControllers = [homeVC,jobdetailvc]
                            self.window?.rootViewController = nav
                        }
                    }
                }
            }
        }*/
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey  : Any] = [:]) -> Bool {
      if (url.host == "oauth-callback") {
        if (options[.sourceApplication] as? String == "com.apple.SafariViewService") {
            OAuthSwift.handle(url: url)
        }
      }else if (url.host == "url=https"){
          if !APIClient.oauthClient.client.credential.oauthToken.isEmpty  {
              if let lastcomponent = url.absoluteString.components(separatedBy: "=").last {
                  if let url = URL(string: lastcomponent) {
                      self.service.fetchIssue(issueId: url.lastPathComponent) { (issue) in
                          let homeVC = UIStoryboard(name: "JobList", bundle: nil).instantiateInitialViewController()! as! JobListViewController
                          let jobdetailvc = UIStoryboard(name: "Job", bundle:nil).instantiateViewController(withIdentifier: "JobViewController") as! JobViewController
                          jobdetailvc.viewModel = JobViewModel(issue: issue)
                          let nav = UINavigationController()
                          nav.viewControllers = [homeVC,jobdetailvc]
                          self.window?.rootViewController = nav
                      }
                  }
              }
          }
      }
      return true
    }
    
}

// MARK: handle callback url
extension AppDelegate {
    
    func applicationHandle(url: URL) {
        if (url.host == "oauth-callback") {
            OAuthSwift.handle(url: url)
        } else {
            // Google provider is the only one wuth your.bundle.id url schema.
            OAuthSwift.handle(url: url)
        }
    }
}
