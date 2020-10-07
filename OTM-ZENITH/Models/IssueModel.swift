//
//  IssueModel.swift
//  OTM-ZENITH
//
//  Created by Nam Phong Nguyen on 10/6/20.
//  Copyright © 2020 Ram Suthar. All rights reserved.
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
