//
//  IssueModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 10/6/20.
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
	
	init() {
		
	}
	
	init(_ json: JSON) {
		customer = json["customfield_10056"].stringValue
		vehicle_brand = json["customfield_10062"].stringValue
		vehicle_type = json["customfield_10063"].stringValue
		vehicle_version = json["customfield_10064"].stringValue
		summary = json["summary"].stringValue
	}
}
