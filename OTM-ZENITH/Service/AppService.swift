//
//  AppService.swift
//  OTM-ZENITH
//
//  Created by Nam Phong Nguyen on 10/30/20.
//  Copyright © 2020 Ram Suthar. All rights reserved.
//

import UIKit
import SwiftyJSON
import JWTDecode

class AppService {
	
	static var shared = AppService()
	
	var client: APIClient
	let cloudId = "0322c746-c9ad-4bf8-8033-022305956776"
	
	init() {
		client = APIClient()
	}
	
	func sendWorkingEvent(start: Bool, longitude: Double, latitude: Double, completion: @escaping() -> Void, failure: @escaping AppServiceFailure) {
		
		getUserInfo(completion: { (userInfo) in
			var params = ["longitude": longitude, "latitude": latitude, "time": Date().timeIntervalSince1970] as [String: Any]
			params["status"] = start == true ? "start" : "stop"
			params["user"] = userInfo
			do {
				let data = try JSON(params).rawData()
				self.client.post(url: "https://ffulz4awrg.execute-api.eu-central-1.amazonaws.com", data: data) { (result) in
					let json = JSON(result)
					print(json)
					completion()
				}
			} catch(let error) {
				failure(error)
			}
		}, failure: failure)
		
	}
	
	func getUserInfo(completion: @escaping(JSON) -> Void, failure: @escaping AppServiceFailure) {
		let token = APIClient.oauthClient.client.credential.oauthToken
		do {
			let jwt = try decode(jwt: token)
			let accountId = jwt.subject?.components(separatedBy: "|").last ?? ""
			
			let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/user"
			client.get(url: url, params: ["accountId": accountId]) { (result) in
				let json = JSON(result)
				completion(json)
			}
			
		} catch(let error) {
			failure(error)
		}
		
	}
}
