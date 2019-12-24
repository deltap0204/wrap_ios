//
//  JobViewController.swift
//  OTM-ZENITH
//
//  Created by Ram Suthar on 21/12/19.
//  Copyright © 2019 Ram Suthar. All rights reserved.
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
    @IBOutlet var contactTapGesture: UITapGestureRecognizer!
    
    var viewModel: JobViewModel!
    var detailVC: DetailsViewController!
    var vehicleVC: VehicleViewController!
    var workVC: WorkViewController!
    var remarkVC: RemarkViewController!
    var photosVC: PhotosViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        title = viewModel.title
        contact.text = viewModel.contact
        location.text = viewModel.address
        
        detailVC.details.text = viewModel.detail
                
        detailContainer.isHidden = false
        vehicleContainer.isHidden = true
        workContainer.isHidden = true
        remarkContainer.isHidden = true
        photosContainer.isHidden = true
        
        locationTapGesture.isEnabled = viewModel.hasLocation
        contactTapGesture.isEnabled = viewModel.hasPhone
    }
    
    @IBAction func changeTab(_ sender: Any) {
        
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
    
    @IBAction func navigate(_ sender: Any) {
        
        let latitude:CLLocationDegrees =  viewModel.latitude
        let longitude:CLLocationDegrees =  viewModel.longitude

        let regionDistance:CLLocationDistance = 10000
        let coordinates = CLLocationCoordinate2DMake(latitude, longitude)
        let regionSpan = MKCoordinateRegion(center: coordinates, latitudinalMeters: regionDistance, longitudinalMeters: regionDistance)
        let options = [
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        ]
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = viewModel.address
        mapItem.openInMaps(launchOptions: options)
    }
    
    @IBAction func call(_ sender: Any) {
        let url = URL(string: "tel://\(viewModel.phone)")
        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let vc = segue.destination as? DetailsViewController {
            detailVC = vc
        }
        else if let vc = segue.destination as? VehicleViewController {
            vehicleVC = vc
            vehicleVC.viewModel = VehicleViewModel(issue: viewModel.issue)
        }
        else if let vc = segue.destination as? WorkViewController {
            workVC = vc
        }
        else if let vc = segue.destination as? RemarkViewController {
            remarkVC = vc
        }
        else if let vc = segue.destination as? PhotosViewController {
            photosVC = vc
            photosVC.viewModel = PhotosViewModel(issue: viewModel.issue)
        }
    }
}
