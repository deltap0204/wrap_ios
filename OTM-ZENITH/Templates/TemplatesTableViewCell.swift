//
//  TemplatesTableViewCell.swift
//  OTM-ZENITH
//
//  Created by Nam Phong Nguyen on 10/6/20.
//  Copyright © 2020 Ram Suthar. All rights reserved.
//

import UIKit

class TemplatesTableViewCell: UITableViewCell {

	@IBOutlet weak var keyLabel: UILabel!
	@IBOutlet weak var summaryLabel: UILabel!
	@IBOutlet weak var templateLabel: UILabel!
	@IBOutlet weak var customerLabel: UILabel!
	@IBOutlet weak var vehicleBrandLabel: UILabel!
	@IBOutlet weak var vehicleTypeLabel: UILabel!
	@IBOutlet weak var vehicleVersionLabel: UILabel!
	
	var issue: IssueModel! {
		didSet {
			fillData()
		}
	}
	
	func fillData() {
		if issue == nil {
			return
		}
		
		keyLabel.text = "Key: " + issue.key
		summaryLabel.text = "Summary: " + issue.fields.summary
		templateLabel.text = "This can be used as a template: " + (issue.fields.templates.first?.value ?? "NO")
		customerLabel.text = "Customer: " + issue.fields.customer
		vehicleBrandLabel.text = "Vehicle Brand: " + issue.fields.vehicle_brand
		vehicleTypeLabel.text = "Vehicle Type: " + issue.fields.vehicle_type
		vehicleVersionLabel.text = "Vehicle Version: " + issue.fields.vehicle_version
		
	}


}
