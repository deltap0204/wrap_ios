//
//  VehicleViewController.swift
//  OTM-ZENITH
//
//  Created by Ram Suthar on 22/12/19.
//  Copyright © 2019 Ram Suthar. All rights reserved.
//

import UIKit

class VehicleViewController: UIViewController {

    @IBOutlet var license: UILabel!
    @IBOutlet var objectID: UILabel!
    @IBOutlet var brand: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var km: UILabel!
    
    var viewModel: VehicleViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        license.text = viewModel.license
        objectID.text = viewModel.objectID
        brand.text = viewModel.brand
        type.text = viewModel.type
        km.text = viewModel.km
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
