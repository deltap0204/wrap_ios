//
//  DetailsViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    
	@IBOutlet weak var subjectLabel: UILabel!
	@IBOutlet weak var detailsTextView: UITextView!
	@IBOutlet var templateButton: UIButton!
   
    var viewModel: DetailsViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

		subjectLabel.text = viewModel.title
		detailsTextView.attributedText = viewModel.details.addCssStyle().html2AttributedString
    }
    
    @IBAction func makeTemplate(_ sender: Any) {
        viewModel.makeTemplate()
        templateButton.isEnabled = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
