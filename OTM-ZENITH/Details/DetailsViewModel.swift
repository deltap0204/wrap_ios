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
        
        details = issue.fields?.fieldsDescription?.content?.first?.content?.map({ $0.text ?? "" }).joined(separator: "\n") ?? ""
        
        showLoader = .init(value: false)
        
    }
    
    func makeTemplate() {
        showLoader.onNext(true)
        service.add(comment: "@Arnaud, can you please evaluate this to be a template?", issue: issue) {
            
            self.showLoader.onNext(false)
        }
    }
}
