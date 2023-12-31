//
//  SceneDelegate.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import OAuthSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    let service = IssueService()
    var launchoption : UIScene.ConnectionOptions?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        launchoption = connectionOptions
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
        guard let url = self.launchoption?.urlContexts.first?.url else { return }
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
        }
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    func scene(_ scene: UIScene, openURLContexts URLContexts: Set<UIOpenURLContext>) {
        guard let url = URLContexts.first?.url else {
            return
        }
        if (url.host == "oauth-callback") {
            //if (options[.sourceApplication] as? String == "com.apple.SafariViewService") {
                OAuthSwift.handle(url: url)
            //}
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
    }
}


