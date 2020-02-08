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
import WebKit
import Prephirences

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
    let service = IssueService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = JobListViewModel(service: IssueService())
        
        titleLabel.text = "Jobs"
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
    
    @IBAction func LogOutMethod(_ sender: Any) {
        print("logout click")
        /*let fliter = ScanCodeViewController()
        fliter.qrCodeBack = {controller, code in
            controller.navigationController?.popViewController(animated: true)
            if code.count > 0 {
                if let url = URL(string: code) {
                    print(url.lastPathComponent)
                    self.service.fetchIssue(issueId: url.lastPathComponent) { (issue) in
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Job", bundle:nil)
                        let jobdetailvc = storyBoard.instantiateViewController(withIdentifier: "JobViewController") as! JobViewController
                        jobdetailvc.viewModel = JobViewModel(issue: issue)
                        self.navigationController?.pushViewController(jobdetailvc, animated: true)
                    }
                }
            }
        }
        self.navigationController?.pushViewController(fliter, animated: true)*/
        let alertController = UIAlertController(title:"Log out", message: "Are you sure you want to logout?", preferredStyle: .alert)
        let yesAction = UIAlertAction(title:"Confirm", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
            let dataTypes = Set([WKWebsiteDataTypeCookies,WKWebsiteDataTypeLocalStorage,WKWebsiteDataTypeSessionStorage,WKWebsiteDataTypeWebSQLDatabases,WKWebsiteDataTypeIndexedDBDatabases])
            WKWebsiteDataStore.default().removeData(ofTypes: dataTypes, modifiedSince: NSDate.distantPast, completionHandler: {})
            let storage = HTTPCookieStorage.shared
            storage.cookies?.forEach() { storage.deleteCookie($0) }
            KeychainPreferences.sharedInstance.removeObject(forKey: "credential")
            APIClient.oauthClient.client.credential.oauthToken = ""
            
            let loginVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.navigationController?.setViewControllers([loginVC], animated: false)
        }
        let noAction = UIAlertAction(title: "Cancel", style: .default) { action in
            alertController.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        self.present(alertController, animated: true)

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

extension URL {
    var queryDictionary: [String: String]? {
        guard let query = self.query else { return nil}
        var queryStrings = [String: String]()
        for pair in query.components(separatedBy: "&") {
            if pair.components(separatedBy: "=").count > 1 {
                let key = pair.components(separatedBy: "=")[0]
                let value = pair.components(separatedBy:"=")[1].replacingOccurrences(of: "+", with: " ").removingPercentEncoding ?? ""
                queryStrings[key] = value
            }
        }
        return queryStrings
    }
}
