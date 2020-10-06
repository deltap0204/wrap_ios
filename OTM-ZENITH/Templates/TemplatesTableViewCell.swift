//
//  TemplatesTableViewCell.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 10/6/20.
//  Copyright © 2020 Ram Suthar. All rights reserved.
//

import UIKit

class TemplatesTableViewCell: UITableViewCell {

	@IBOutlet weak var keyLabel: UILabel!
	@IBOutlet weak var vehicleBrandLabel: UILabel!
	@IBOutlet weak var typeLabel: UILabel!
	
	var issue: IssueModel! {
		didSet {
			fillData()
		}
	}
	
	func fillData() {
		if issue == nil {
			return
		}
		
		keyLabel.text = issue.key + ": " + issue.fields.summary
		vehicleBrandLabel.text = [issue.fields.vehicle_brand, issue.fields.vehicle_type, issue.fields.vehicle_version].filter({!$0.isEmpty}).joined(separator: " - ")
		
	}


}
