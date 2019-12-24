//
//  WorkViewController.swift
//  OTM-ZENITH
//
//  Created by Ram Suthar on 21/12/19.
//  Copyright © 2019 Ram Suthar. All rights reserved.
//

import UIKit

class WorkViewController: UIViewController {

    @IBOutlet var routeStart: UIButton!
    @IBOutlet var routeStop: UIButton!
    @IBOutlet var jobStart: UIButton!
    @IBOutlet var jobStop: UIButton!
    @IBOutlet var jobClose: UIButton!
    @IBOutlet var routeView: UIView!
    @IBOutlet var jobView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        routeStart.layer.cornerRadius = 8
        routeStop.layer.cornerRadius = 8
        jobStart.layer.cornerRadius = 8
        jobStop.layer.cornerRadius = 8
        jobClose.layer.cornerRadius = 8
        
        routeView.layer.cornerRadius = 8
        jobView.layer.cornerRadius = 8
        
        routeView.layer.borderColor = UIColor.lightGray.cgColor
        jobView.layer.borderColor = UIColor.lightGray.cgColor
        
        routeView.layer.borderWidth = 0.5
        jobView.layer.borderWidth = 0.5
    }
    
    @IBAction func startRoute(_ sender: Any) {
        
    }
    
    @IBAction func stopRoute(_ sender: Any) {
        
    }
    
    @IBAction func startJob(_ sender: Any) {
        
    }
    
    @IBAction func stopJob(_ sender: Any) {
        
    }
    
    @IBAction func closeJob( _ sender: Any) {
        
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
