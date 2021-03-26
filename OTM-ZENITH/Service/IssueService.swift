//
//  IssueService.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import SwiftyJSON
import CoreLocation

typealias AppServiceFailure = ((Error) -> Void)

func stringify(json: Any, prettyPrinted: Bool = false) -> String {
	var options: JSONSerialization.WritingOptions = []
	if prettyPrinted {
		options = JSONSerialization.WritingOptions.prettyPrinted
	}
	
	do {
		let data = try JSONSerialization.data(withJSONObject: json, options: options)
		if let string = String(data: data, encoding: String.Encoding.utf8) {
			return string
		}
	} catch {
		print(error)
	}
	
	return ""
}

class IssueService {
	
	var client: APIClient
	let cloudId = "0322c746-c9ad-4bf8-8033-022305956776"
	
	init() {
		client = APIClient()
	}
	
	func fetch(date: Date,key:String, completion: @escaping ([Issue]?) -> Void) {
		
		
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "y-M-d"
		let dateString = dateFormatter.string(from: date)
		var jql = "assignee=currentUser()" //used by Freddy to test
		//var jql = "assignee=currentUser() and duedate = " + dateString //the real deal!!
		//var jql = "project = WT AND duedate = " + dateString //to be used for Thomas, Peter, Hendrik, ...
		if(key != ""){
			//			jql = "project = WT AND summary ~\(key) OR  description  ~\(key)"
			//            jql = "project = WT AND key in (\(key))"
			jql = "project = WT AND (summary ~\(key) OR  description  ~\(key) OR key in (\(key)))"
		}
		let params: [String: Any] = ["jql":jql,"fields": [ "*all" ], "validateQuery": "false", "expand": ["renderedFields"]]
		let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/search"
		let data: Data? = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
		client.post(url: url,
					data: data!,
					completion: { (result) in
						if let dt = result as? Data {
							
							
							print(JSON(dt))
							let resURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("issue_response.txt")
							do {
								try dt.write(to: resURL)
								print(resURL.path)
							} catch {
								print(error.localizedDescription)
							}
						}
						let str = String(decoding: result as! Data, as: UTF8.self)
						do{
							let object = try JSONDecoder().decode(SearchIssueResponse.self, from: result as! Data)
							let issues = object.issues
							completion(issues)
						}catch {
							print(error.localizedDescription);
						}
						
						
						
					})
	}
	
	func fetchIssue(issueId: String, completion: @escaping (Issue) -> Void) {
		let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issueId)"
		client.get(url: url,
				   params: [:],
				   completion: { (result) in
					let object = try! JSONDecoder().decode(Issue.self, from: result as! Data)
					completion(object)
				   })
	}
	
	func update(status: StatusCategoryId, issue: Issue, comment: String, completion: @escaping () -> Void) {
		
		let id: Int
		
		switch status {
		case .toDo:
			id = 11
		case .inProgress:
			id = 21
		case .done:
			id = 31
		case .problem:
			id = 41
		}
		
		let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issue.id!)/transitions"
		//let commentsCount = (issue.fields?.worklog?.comments ?? []).count
		var googleMapURL = "https://www.google.com/maps/search/?api=1"
		var locationString = ""
		if let location = LocationService.location {
			googleMapURL = "https://www.google.com/maps/embed/v1/view?key=AIzaSyBhiqcP_bAdHxn2PIilDhj76W7rHhQBmwE&center=\(location.latitude),\(location.longitude)&zoom=18"
			// googleMapURL = googleMapURL + "&query=\(location.latitude),\(location.longitude))"
			locationString = "\(location.latitude),\(location.longitude)"
			
		}
		let params: [String: Any] = ["transition": ["id": "\(id)","update": ["fields":["status":["id":"10124"]]]]]
		
		//let params: [String: [String: String]] = ["transition": ["id": "\(id)"],"fields":["customfield_10132": googleMapURL]]
		
		let data: Data? = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
		
		self.client.post(url: url,
						 data: data!,
						 completion: { (result) in
							self.add(comment: comment, issue: issue) {
								
								completion()
							}
						 })
	}
	
	
	
	
	func add(comment: String, issue: Issue, completion: @escaping () -> Void) {
		
		let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issue.id!)/comment"
		
		let body = Body(
			content: [
				BodyContent(
					content: [
						PurpleContent(text: comment, type: .text, attrs: nil)
					],
					type: .paragraph
				)
			],
			type: .doc,
			version: 1
		)
		
		let params = CommentElement(commentSelf: nil, id: nil, author: nil, body: body, updateAuthor: nil, created: nil, updated: nil, jsdPublic: nil)
		
		let data = try? JSONEncoder().encode(params)
		
		client.post(url: url,
					data: data!,
					completion: { [self] (result) in
						
						
						
						
						if(!comment.contains("a remark was added")){
							var googleMapURL = "https://www.google.com/maps/search/?api=1"
							var locationString = ""
							if let location = LocationService.location {
                                //googleMapURL = "https://www.google.com/maps/search/?api=1&query=\(location.latitude),\(location.longitude)"
								googleMapURL = "https://www.google.com/maps/embed/v1/view?key=AIzaSyBhiqcP_bAdHxn2PIilDhj76W7rHhQBmwE&center=\(location.latitude),\(location.longitude)&zoom=18"
								
								//   googleMapURL = googleMapURL + "&query=\(location.latitude),\(location.longitude))"
								locationString = "\(location.latitude),\(location.longitude)"
								getAddressFromLocation(coordinate: location) { (addressString) in
									self.updateMetaData(googleURL:googleMapURL, location:locationString,issue: issue) {
										completion()
									}
								}
								
							} else {
								self.updateMetaData(googleURL:googleMapURL,location:locationString,issue: issue) {
									completion()
								}
							}
							
							
						}else{
							completion()
						}
						
						
					})
	}
	
	func updateMetaData( googleURL:String,location:String,issue: Issue, completion: @escaping () -> Void) {
		
		let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/2/issue/\(issue.key!)"
		let params = ["fields":["customfield_10132":googleURL]]
		let data: Data? = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
		client.put(url: url,
				   params: params,
				   completion: { (result) in
					completion()
					
				   })
		
	}
	
	func updateVehicleInfo(issue: Issue, license_plate: String, object_id: String, brand: String, type: String, km: Double, completion: @escaping() -> Void) {
		
		let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issue.key!)"
		let params = ["fields":["customfield_10059": license_plate, "customfield_10058": object_id, "customfield_10062": brand.capitalizingFirstLetter(), "customfield_10063": type.capitalizingFirstLetter(), "customfield_10083": km]]
		client.put(url: url,
				   params: params,
				   completion: { (result) in
					completion()
					NotificationCenter.default.post(name: NSNotification.Name.init("reload_tasks"), object: nil)
				   })
		
	}
	
	func updateRemarks(issue: Issue,
					   washInstructions: Bool, vehicleLate: Bool, vehicleDirty: Bool,
					   fluviusContainer: Bool, railroadCrossing: Bool, positionNotClear: Bool, redWhiteNotMounted: Bool, GPSnotCorrect: Bool,
					   infrabelContainer: Bool, plateHolder: Bool, interventionOfCarglass: Bool, interventionOfTiers: Bool, onlyRemoveTheLogo: Bool, removeMoreThanLogo: Bool, carPainted: Bool, completion: @escaping() -> Void) {
		let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issue.key!)"
		
		var defaultInstruction = [[String: Any]]()
		if washInstructions {
			defaultInstruction.append(["id": "10116"])
		}
		if vehicleDirty {
			defaultInstruction.append(["id": "10304"])
		}
		if vehicleLate {
			defaultInstruction.append(["id": "10328"])
		}
		
		var fields = [String: Any]()
		fields["customfield_10080"] = defaultInstruction
		
		if fluviusContainer {
			var customFields10105Values = [[String: Any]]()
			if plateHolder {
				customFields10105Values.append(["id": "10329"])
			}
			if interventionOfCarglass {
				customFields10105Values.append(["id": "10364"])
			}
			if interventionOfTiers {
				customFields10105Values.append(["id": "10365"])
			}
			if onlyRemoveTheLogo {
				customFields10105Values.append(["id": "10366"])
			}
			if removeMoreThanLogo {
				customFields10105Values.append(["id": "10367"])
			}
			if carPainted {
				customFields10105Values.append(["id": "10368"])
			}
			fields["customfield_10105"] = customFields10105Values
			
		}
		if infrabelContainer {
			var infrabelInstructions = [[String: Any]]()
			if railroadCrossing {
				infrabelInstructions.append(["id": "10203"])
			}
			if positionNotClear {
				infrabelInstructions.append(["id": "10204"])
			}
			if redWhiteNotMounted {
				infrabelInstructions.append(["id": "10235"])
			}
			if GPSnotCorrect {
				infrabelInstructions.append(["id": "10236"])
			}
			fields["customfield_10128"] = infrabelInstructions
			
		}

		let params = ["fields": fields]
		client.put(url: url,
				   params: params,
				   completion: { (result) in
					completion()
					NotificationCenter.default.post(name: NSNotification.Name.init("reload_tasks"), object: nil)
				   })
	}
	
	func getAddressFromLocation(coordinate: CLLocationCoordinate2D, completion: @escaping (String) -> Void) {
		let geocoder: CLGeocoder = CLGeocoder()
		let location: CLLocation = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
		geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
			if (error != nil)
			{
				completion("")
				return
			}
			let pm = placemarks! as [CLPlacemark]
			
			if pm.count > 0 {
				let pm = placemarks![0]
				var addressString : String = ""
				if pm.name != nil {
					addressString = addressString + pm.name! + ", "
				}
				if pm.subLocality != nil {
					addressString = addressString + pm.subLocality! + ", "
				}
				if pm.thoroughfare != nil {
					addressString = addressString + pm.thoroughfare! + ", "
				}
				if pm.locality != nil {
					addressString = addressString + pm.locality! + ", "
				}
				if pm.country != nil {
					addressString = addressString + pm.country! + ", "
				}
				if pm.postalCode != nil {
					addressString = addressString + pm.postalCode! + " "
				}
				completion(addressString)
			} else {
				completion("")
			}
			
			
		}
		
		
	}
}
