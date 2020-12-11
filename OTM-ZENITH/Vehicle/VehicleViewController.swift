//
//  VehicleViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 22/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class VehicleViewController: UIViewController {

	@IBOutlet weak var licenseTextField: UITextField!
	@IBOutlet weak var objectIDTextField: UITextField!
	@IBOutlet weak var brandTextField: UITextField!
	@IBOutlet weak var typeTextField: UITextField!
	@IBOutlet weak var kmTextField: UITextField!
	
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var problem: UITextView!
    @IBOutlet var buttonEnter: UIButton!
	@IBOutlet weak var buttonSendBottomConstraint: NSLayoutConstraint!
	
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var overlayView: UIView!
    
    var viewModel: VehicleViewModel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        licenseTextField.text = viewModel.license
        objectIDTextField.text = viewModel.objectID
        brandTextField.text = viewModel.brand
        typeTextField.text = viewModel.type
        kmTextField.text = viewModel.km
        
        problem.layer.cornerRadius = 8
        buttonEnter.layer.cornerRadius = 8
        
        bindViewModel()
    }

    private func bindViewModel() {

        viewModel.showLoader.map({ !$0 }).bind(to: overlayView.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.showSuccessMessage.bind(onNext: { self.alert(message: $0) }).disposed(by: disposeBag)
        
        //        viewModel.showLoader.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
    }
    
    @IBAction func submit(_ sender: Any) {
        problem.resignFirstResponder()
        
        self.viewModel.submit(problem: self.problem.text)
        self.problem.text = ""
    //    self.buttonEnter.setTitle("Problem", for: .normal);
        
    }
	
	@IBAction func doSaveButton(_ sender: Any) {
		self.view.endEditing(true)
		let km = Double(kmTextField.text ?? "0") ?? 0
		self.viewModel.updateVehicleInfo(license_plate: licenseTextField.text ?? "", object_id: objectIDTextField.text ?? "", brand: brandTextField.text ?? "", type: typeTextField.text ?? "", km: km)
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
