//
//  DetailsViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 09/01/20.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class DetailsViewModel {
    
	let title: String
	
    let details: String
    
    let issue: Issue
    
    let showLoader: BehaviorSubject<Bool>
    
    let service: IssueService!
    
	init(title: String = "", issue: Issue) {
		self.title = title
		
        self.issue = issue
        
        self.service = IssueService()
		
		self.details = issue.renderedFields?["description"].stringValue ?? ""
		
        showLoader = .init(value: false)
        
    }
    
    func makeTemplate() {
        showLoader.onNext(true)
        service.add(comment: "@Arnaud, can you please evaluate this to be a template?", issue: issue) {
            
            self.showLoader.onNext(false)
        }
    }
	
	func getJobDetail() {
		
	}
	
}
