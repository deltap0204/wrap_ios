//
//  TemplatesViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 10/6/20.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import UIKit
import DTPhotoViewerController

class TemplatesViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	
	var issue: Issue!
	private var datasource = [IssueModel]() {
		didSet {
			tableView?.reloadData()
		}
	}
	private var selectedTemplate: IssueModel!
	
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
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.selectedTemplate = datasource[indexPath.row]
		
		let cell = tableView.cellForRow(at: indexPath)! as! TemplatesTableViewCell
		
		let viewController = PhotoVController(referencedView: cell, image: nil)
		viewController.dataSource = self
		present(viewController, animated: true)
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
			(viewController.scrollView as! UICollectionView).scrollToItem(at: indexPath, at: .centeredHorizontally, animated: false)
		}
	}
}


extension TemplatesViewController: DTPhotoViewerControllerDataSource {
	
	func numberOfItems(in photoViewerController: DTPhotoViewerController) -> Int {
		
		return selectedTemplate?.fields.attachments.count ?? 0
	}
	
	func photoViewerController(_ photoViewerController: DTPhotoViewerController, referencedViewForPhotoAt index: Int) -> UIView? {
		return nil
	}
	
	func photoViewerController(_ photoViewerController: DTPhotoViewerController, configurePhotoAt index: Int, withImageView imageView: UIImageView) {
		
		
		guard let url = URL(string: selectedTemplate.fields.attachments[index].content) else {
			imageView.kf.indicator?.startAnimatingView()
			return
		}
		imageView.kf.indicatorType = .activity

		imageView.kf.setImage(with: url, options: [.requestModifier(ImageDownloadTokenManager())]) { (result) in
			print(result)
		}
		
	}
	
	
}
