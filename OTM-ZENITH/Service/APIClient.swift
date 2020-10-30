//
//  APIClient.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import OAuthSwift
import Prephirences
import Kingfisher

class APIClient {
    
    static let webClient = WebClient()
    
    static let oauthClient: OAuth2Swift = {
//        let key = "Fx6m0ehw9MFkS2LfyDH13kfif4JrDU5L" // otm-zenith
//        let secret = "QNwgGZQyKQKDHoJlquWVMi-CIND7YsFySAJRdQ2kxooxKQ_-f-sfj1Jh9euRon_Y" // otm-zenith
        let key = "4RpYG2Ui8KYCXZMgtZ85d7OU7Wvu3ENi" // OTM-Zenith Wrapping
        
        let secret = "VSO2E--XB4w85kDowFyR6BP51ekRH9YBnKlZ1onY00D3WyM-mDPC4TrMjHpXT9XY" // OTM-Zenith Wrapping
        //        let key = "UERRMTEy3A61QzXJ9O4gTLqRUc9eCJQK" // reallyram
        //        let secret = "yTZKz8Oy-QxinUGW8c6IGo6EaxC68AsWowIeFD_eAk3O84eTGTyN1pvYA68hrUrP" // reallyram
        
        let oauthClient = OAuth2Swift(
            consumerKey:    key,
            consumerSecret: secret,
            authorizeUrl:   "https://auth.atlassian.com/authorize?audience=api.atlassian.com&prompt=consent",
            accessTokenUrl: "https://auth.atlassian.com/oauth/token",
            responseType:   "code"
        )
        
        oauthClient.client.sessionFactory.configuration.httpCookieStorage = HTTPCookieStorage.shared
        oauthClient.client.sessionFactory.configuration.httpShouldSetCookies = true
        
        var keychain = KeychainPreferences.sharedInstance
        if let credential = keychain["credential"] as? OAuthSwiftCredential {
            oauthClient.client.credential.oauthToken = credential.oauthToken
            oauthClient.client.credential.oauthRefreshToken = credential.oauthRefreshToken
            oauthClient.client.credential.oauthTokenSecret = credential.oauthTokenSecret
            oauthClient.client.credential.oauthTokenExpiresAt = credential.oauthTokenExpiresAt
        }
        
        return oauthClient
    }()
    
    /*
     deltap0204@outlook.com
     Toplevel123
     */
    
    func login(completion: @escaping (Any?) -> Void) {
        
        let state = generateState(withLength: 20)
                
        let _ = APIClient.oauthClient.authorize(
            withCallbackURL: URL(string: "otm-zenith://oauth-callback/jira")!,
            scope: "read:jira-user read:jira-work write:jira-work offline_access manage:jira-project", state:state) { result in
            switch result {
            case .success(let (credential, response, parameters)):
              print(credential.oauthToken)
              
              // Save token data
              var keychain = KeychainPreferences.sharedInstance
              keychain["credential", .archive] = credential
              
              // Do your request
              completion(nil)
            case .failure(let error):
              print(error.localizedDescription)
            }
        }
    }
    
    func upload(url: String,
                image: Data,
                completion: @escaping (Any?) -> Void) {
        let headers = [
            "X-Atlassian-Token" : "no-check"
        ]
        
        let multiparts = [ OAuthSwiftMultipartData(name: "file", data: image, fileName: "picture.jpg", mimeType: "image/jpeg") ]
        
        APIClient.oauthClient.client.postMultiPartRequest(url, method: .POST, parameters: [:], headers: headers, multiparts: multiparts, checkTokenExpiration: true) { (result) in
            
            switch result {
            case .success(let response):
                debugPrint(response)
                completion(response.data)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func post(url: String,
             data: Data,
             completion: @escaping (Any?)-> Void) {
        let headers = [
            "Content-Type" : "application/json"
        ]
        
        APIClient.oauthClient.startAuthorizedRequest(url, method: .POST, parameters: [:], headers: headers, renewHeaders: nil, body: data, onTokenRenewal: nil) { (result) in
            
            switch result {
            case .success(let response):
                debugPrint(response)
                completion(response.data)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func put(url: String,
             params: [String: Any]?,
             completion: @escaping (Any?)-> Void) {
        APIClient.oauthClient.startAuthorizedRequest(url, method: .PUT, parameters: params!,headers: ["Content-Type":"application/json"]) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                completion(response.data)
            case .failure(let error):
                debugPrint(error)
            }
        }
    }
    
    func get(url: String,
             params: [String: Any]?,
             completion: @escaping (Any?)-> Void) {
        
//        APIClient.oauthClient.client.get(url, parameters: params!, headers: nil) { (result) in
//            switch result {
//            case .success(let response):
//                debugPrint(response)
//            case .failure(let error):
//                debugPrint(error)
//            }
//        }
        
        APIClient.oauthClient.startAuthorizedRequest(url, method: .GET, parameters: params!, headers: ["Content-Type":"application/json"]) { (result) in
            switch result {
            case .success(let response):
                debugPrint(response)
                completion(response.data)
            case .failure(let error):
                debugPrint(error)
            }
        }
        
        
//        let headers = [
//            "Authorization":"Bearer \(oauthToken)",
//        ]
//
//        Alamofire.request(url, method: .get, parameters: params, headers: headers)
//            .validate(statusCode: 200..<300)
//            .responseJSON { response in
//                if (response.result.error == nil) {
//                    debugPrint("HTTP Response Body: \(response.data)")
//
//                    completion(response.result)
//                }
//                else {
//                    if response.response?.statusCode == 401 {
//
//                    }
//                    debugPrint("HTTP Request failed: \(response.result.error)")
//                }
//        }
        
    }
}
