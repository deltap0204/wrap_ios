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

    @IBOutlet var license: UILabel!
    @IBOutlet var objectID: UILabel!
    @IBOutlet var brand: UILabel!
    @IBOutlet var type: UILabel!
    @IBOutlet var km: UILabel!
    
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
        
        license.text = viewModel.license
        objectID.text = viewModel.objectID
        brand.text = viewModel.brand
        type.text = viewModel.type
        km.text = viewModel.km
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
