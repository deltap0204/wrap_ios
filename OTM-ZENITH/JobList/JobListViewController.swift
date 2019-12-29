//
//  JobListViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class JobListViewController: UIViewController {
    
    let cellIdentifier = "JobCell"
    var viewModel: JobListViewModel!
    
    @IBOutlet var dateButton: UIButton!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var previousDateButton: UIBarButtonItem!
    @IBOutlet var nextDateButton: UIBarButtonItem!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var doneButton: UIBarButtonItem!
    @IBOutlet var datePickerContainer: UIView!
    @IBOutlet var noJobsLabel: UILabel!
    
    let refreshControl = UIRefreshControl()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = JobListViewModel(service: IssueService())
        
        titleLabel.text = "Open Jobs"
        datePicker.date = viewModel.date
        
        tableView.delegate = nil
        tableView.dataSource = nil
        
        refreshControl.addTarget(self, action: #selector(loadDate(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
        
        datePickerContainer.isHidden = true
        
        bindViewModel()
    }
    
    @IBAction func loadPrevious(_ sender: Any) {
        viewModel.loadPrevDate()
    }
    
    @IBAction func loadNext(_ sender: Any) {
        viewModel.loadNextDate()
    }
    
    @IBAction func loadDate(_ sender: Any) {
        viewModel.loadDate(date: datePicker.date)
        
        hideDatePicker()
    }
    
    @IBAction func showDatePicker(_ sender: Any) {
        
        datePickerContainer.isHidden = false
        datePickerContainer.transform = CGAffineTransform(translationX: 0, y: datePickerContainer.bounds.height)
        UIView.animate(withDuration: 0.3) {
            self.datePickerContainer.transform = .identity
        }
    }
    
    func hideDatePicker() {
        
        datePickerContainer.transform = .identity
        UIView.animate(withDuration: 0.3, animations: {
            self.datePickerContainer.transform = CGAffineTransform(translationX: 0, y: self.datePickerContainer.bounds.height)
        }, completion: { _ in
            self.datePickerContainer.isHidden = true
        })
    }
    
    func bindViewModel() {
        
        viewModel.title
            .bind(to: dateButton.rx.title())
            .disposed(by: disposeBag)
        
        viewModel.showLoader
//            .map({ !$0 })
            .bind(to: refreshControl.rx.isRefreshing)
            .disposed(by: disposeBag)
        
        viewModel.hasJobs
            .bind(to: noJobsLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        viewModel.jobs
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier)) {(index, job, cell) in
                
                if let cell = cell as? JobCell {
                    cell.name.text = job.summary
                    cell.location.text = job.location
                    cell.client.text = job.client
                    
                    cell.statusIndicator.backgroundColor = UIColor(named: job.statusColor ?? "black")
                }
        }
        .disposed(by: disposeBag)
        
        
    }
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
        if let vc = segue.destination as? JobViewController {
            let index = tableView.indexPathForSelectedRow?.row ?? 0
            let issue = viewModel.issues[index]
            vc.viewModel = JobViewModel(issue: issue)
        }
     }
     
    
}
