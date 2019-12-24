//
//  JobListViewController.swift
//  OTM-ZENITH
//
//  Created by Ram Suthar on 20/12/19.
//  Copyright © 2019 Ram Suthar. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class JobListViewController: UIViewController {
    
    let cellIdentifier = "JobCell"
    var viewModel: JobListViewModel!
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var previousDateButton: UIBarButtonItem!
    @IBOutlet var nextDateButton: UIBarButtonItem!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = JobListViewModel(service: IssueService())
        
        navigationItem.title = "Open Jobs"
        
        tableView.delegate = nil
        tableView.dataSource = nil
        
        bindViewModel()
    }
    
    @IBAction func loadPrevious(_ sender: Any) {
        viewModel.loadPrevDate()
    }
    
    @IBAction func loadNext(_ sender: Any) {
        viewModel.loadNextDate()
    }
    
    func bindViewModel() {
        
        viewModel.title
            .bind(onNext: { [weak self] (title) in
                self?.navigationItem.prompt = title
            })
            .disposed(by: disposeBag)
        
        viewModel.showLoader
            .map({ !$0 })
            .bind(to: loadingIndicator.rx.isHidden)
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
