//
//  JobCell.swift
//  OTM-ZENITH
//
//  Created by Ram Suthar on 20/12/19.
//  Copyright © 2019 Ram Suthar. All rights reserved.
//

import UIKit

class JobCell: UITableViewCell {

    @IBOutlet var name: UILabel!
    @IBOutlet var location: UILabel!
    @IBOutlet var client: UILabel!
    @IBOutlet var bgView: UIView!
    @IBOutlet var statusIndicator: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        bgView.layer.cornerRadius = 8
        bgView.clipsToBounds = true
        
        statusIndicator.layer.cornerRadius = 10
        statusIndicator.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
