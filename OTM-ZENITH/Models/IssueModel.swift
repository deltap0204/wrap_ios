//
//  IssueModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 10/6/20.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import UIKit
import SwiftyJSON

class IssueModel {
	
	var key = ""
	var id = ""
	var issueSelf = ""
	var expand = ""
	var fields = FieldsModel()
	
	init(_ json: JSON) {
		key = json["key"].stringValue
		id = json["id"].stringValue
		issueSelf = json["self"].stringValue
		expand = json["expand"].stringValue
		fields = FieldsModel(json["fields"])
	}
}

class FieldsModel {
	
	var customer = ""
	var vehicle_brand = ""
	var vehicle_type = ""
	var vehicle_version = ""
	var summary = ""
	var attachments = [AttachmentModel]()
	var templates = [CustomFieldModel]()
	
	init() {
		
	}
	
	init(_ json: JSON) {
		summary = json["summary"].stringValue
		templates = json["customfield_10189"].arrayValue.map({CustomFieldModel($0)})
		customer = json["customfield_10056"].stringValue
		vehicle_brand = json["customfield_10062"].stringValue
		vehicle_type = json["customfield_10063"].stringValue
		vehicle_version = json["customfield_10064"].stringValue
		attachments = json["attachment"].arrayValue.map({AttachmentModel($0)})
	}
}

class CustomFieldModel {
	var customFieldSelf = ""
	var value = ""
	var id = ""
	
	init(_ json: JSON) {
		customFieldSelf = json["self"].stringValue
		value = json["value"].stringValue
		id = json["id"].stringValue
	}
}

class AttachmentModel {
	var mimeType = ""
	var created_at = ""
	var id = ""
	var filename = ""
	var thumbnail = ""
	var content = ""
	var size: Double = 0
	
	init(_ json: JSON) {
		mimeType = json["mimeType"].stringValue
		created_at = json["created_at"].stringValue
		id = json["id"].stringValue
		filename = json["filename"].stringValue
		thumbnail = json["thumbnail"].stringValue
		content = json["content"].stringValue
		size = json["size"].doubleValue
	}
}
