//
//  JobViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import MapKit

class JobViewController: UIViewController {

    @IBOutlet var location: UILabel!
    @IBOutlet var contact: UILabel!
    @IBOutlet var tab: UISegmentedControl!
    @IBOutlet var headerView: UIView!
    @IBOutlet var headerHeight: NSLayoutConstraint!
    @IBOutlet var detailContainer: UIView!
    @IBOutlet var vehicleContainer: UIView!
    @IBOutlet var workContainer: UIView!
    @IBOutlet var remarkContainer: UIView!
    @IBOutlet var photosContainer: UIView!
    @IBOutlet var locationTapGesture: UITapGestureRecognizer!
    @IBOutlet var leftSwipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var rightSwipeGesture: UISwipeGestureRecognizer!
    @IBOutlet var contactTapGesture: UITapGestureRecognizer!
    
    var viewModel: JobViewModel!
    var detailVC: DetailsViewController!
    var vehicleVC: VehicleViewController!
    var workVC: WorkViewController!
    var remarkVC: RemarkViewController!
    var photosVC: PhotosViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.title
        contact.text = viewModel.contact
        location.text = viewModel.address
                
        detailContainer.isHidden = false
        vehicleContainer.isHidden = true
        workContainer.isHidden = true
        remarkContainer.isHidden = true
        photosContainer.isHidden = true
        
        locationTapGesture.isEnabled = viewModel.hasLocation
        contactTapGesture.isEnabled = viewModel.hasPhone
    }
    
    @IBAction func changeTab(_ sender: Any) {
        
        switchTab()
    }
    
    @IBAction func swipeGestureHandler(_ sender: Any) {
        guard let gesture = sender as? UISwipeGestureRecognizer else { return }
        let newIndex = (tab.selectedSegmentIndex) + (gesture.direction == .right ? -1 : 1)
        
        if gesture.direction == .right {
            if newIndex >= 0 {
                tab.selectedSegmentIndex = newIndex
            }
        } else {
            if newIndex <= tab.numberOfSegments {
                tab.selectedSegmentIndex = newIndex
            }
        }
        switchTab()
    }
    @IBAction func navigate(_ sender: Any) {
        var urlStr = "https://www.google.com/maps/place/\(viewModel.address)";
        urlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "";
        let url = URL(string: urlStr)
        if(url != nil){
            if(UIApplication.shared.canOpenURL(url!)){
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
        }
    }
    
    @IBAction func call(_ sender: Any) {
        let url = URL(string: "tel://\(viewModel.phone)")
        if(url != nil){
            if(UIApplication.shared.canOpenURL(url!)){
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
            }
        }
       
       
    }
    
    // MARK: - Navigation

    private func switchTab() {
        detailContainer.isHidden = true
        vehicleContainer.isHidden = true
        workContainer.isHidden = true
        remarkContainer.isHidden = true
        photosContainer.isHidden = true
        
        switch tab.selectedSegmentIndex {
        case 0:
            detailContainer.isHidden = false
        case 1:
            vehicleContainer.isHidden = false
        case 2:
            workContainer.isHidden = false
        case 3:
            remarkContainer.isHidden = false
        case 4:
            photosContainer.isHidden = false
        default:
            detailContainer.isHidden = false
        }
    }
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? DetailsViewController {
            detailVC = vc
            detailVC.viewModel = DetailsViewModel(issue: viewModel.issue)
        }
        else if let vc = segue.destination as? VehicleViewController {
            vehicleVC = vc
            vehicleVC.viewModel = VehicleViewModel(issue: viewModel.issue)
        }
        else if let vc = segue.destination as? WorkViewController {
            workVC = vc
            workVC.viewModel = WorkViewModel(issue: viewModel.issue)
        }
        else if let vc = segue.destination as? RemarkViewController {
            remarkVC = vc
            remarkVC.viewModel = RemarkViewModel(issue: viewModel.issue)
        }
        else if let vc = segue.destination as? PhotosViewController {
            photosVC = vc
            photosVC.viewModel = PhotosViewModel(issue: viewModel.issue)
        }
    }
}
