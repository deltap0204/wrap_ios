//
//  DetailsViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 09/01/20.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import Foundation
import RxSwift

class DetailsViewModel {
    
    let details: String
    
    let issue: Issue
    
    let showLoader: BehaviorSubject<Bool>
    
    let service: IssueService!
    
    init(issue: Issue) {
    
        self.issue = issue
        
        self.service = IssueService()
		
		var tempDescription = ""
		if let contents = issue.fields?.fieldsDescription?.content {
			for content in contents {
				var paragraph = ""
				if content.content != nil {
					paragraph = content.content!.map({$0.text ?? ""}).joined(separator: " ")
				}
				if !paragraph.isEmpty {
					if tempDescription.isEmpty {
						tempDescription = paragraph
					} else {
						tempDescription += "\n" + paragraph
					}
				}
			}
		}
		details = tempDescription

        showLoader = .init(value: false)
        
    }
    
    func makeTemplate() {
        showLoader.onNext(true)
        service.add(comment: "@Arnaud, can you please evaluate this to be a template?", issue: issue) {
            
            self.showLoader.onNext(false)
        }
    }
}
