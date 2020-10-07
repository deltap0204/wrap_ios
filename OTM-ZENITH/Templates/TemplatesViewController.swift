//
//  TemplatesViewController.swift
//  OTM-ZENITH
//
//  Created by Nam Phong Nguyen on 10/6/20.
//  Copyright © 2020 Ram Suthar. All rights reserved.
//

import UIKit

class TemplatesViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var issue: Issue!
	private var datasource = [IssueModel]() {
		didSet {
			tableView?.reloadData()
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
		loadData()
    }

	func setupUI() {
		tableView.tableFooterView = UIView()
		tableView.rowHeight = UITableView.automaticDimension
		tableView.estimatedRowHeight = 200
	}
	
	func loadData() {
		IssueService().getTemplates(customer: issue.fields?.customfield10056 ?? "", vehicle_brand: issue.fields?.customfield10062 ?? "") { [unowned self] objects in
			self.datasource = objects
		} failure: { [unowned self](error) in
			debugPrint(error.localizedDescription)
		}

	}

}

extension TemplatesViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return datasource.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "TemplatesTableViewCell", for: indexPath) as! TemplatesTableViewCell
		
		cell.issue = datasource[indexPath.row]
		
		return cell
	}
}

extension TemplatesViewController: UITableViewDelegate {

}
