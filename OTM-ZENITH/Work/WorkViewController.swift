//
//  WorkViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class WorkViewController: UIViewController {

    var viewModel: WorkViewModel!
    
    @IBOutlet var routeStart: UIButton!
    @IBOutlet var routeStop: UIButton!
    @IBOutlet var jobStart: UIButton!
    @IBOutlet var jobStop: UIButton!
    @IBOutlet var jobClose: UIButton!
    @IBOutlet var routeView: UIView!
    @IBOutlet var jobView: UIView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var overlayView: UIView!
    
    let disposeBag = DisposeBag()
    
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
        let status =  viewModel.issue.fields?.status
        if(status?.id == "10032"){
            self.jobStart.isEnabled = false
            self.jobStop.isEnabled = false
            self.routeStop.isEnabled = false
            self.routeStart.isEnabled = false
        }else{
            self.jobStart.isEnabled = true
            self.jobStop.isEnabled = true
            self.routeStop.isEnabled = true
            self.routeStart.isEnabled = true
        }
        bindViewModel()
    }
    
    private func bindViewModel() {
        
        viewModel.showLoader.map({ !$0 }).bind(to: overlayView.rx.isHidden).disposed(by: disposeBag)
        
        viewModel.enableStartJob.bind(to: jobStart.rx.isEnabled).disposed(by: disposeBag)
        viewModel.enableStopJob.bind(to: jobStop.rx.isEnabled).disposed(by: disposeBag)
        viewModel.enableCloseJob.bind(to: jobClose.rx.isEnabled).disposed(by: disposeBag)
        viewModel.enableStartRoute.bind(to: routeStart.rx.isEnabled).disposed(by: disposeBag)
        viewModel.enableStopRoute.bind(to: routeStop.rx.isEnabled).disposed(by: disposeBag)
    }
    
    @IBAction func startRoute(_ sender: Any) {
        viewModel.startRoute()
    }
    
    @IBAction func stopRoute(_ sender: Any) {
        viewModel.stopRoute()
    }
    
    @IBAction func startJob(_ sender: Any) {
        viewModel.startJob()
    }
    
    @IBAction func stopJob(_ sender: Any) {
        viewModel.stopJob()
    }
    
    @IBAction func closeJob( _ sender: Any) {
        viewModel.closeJob()
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
