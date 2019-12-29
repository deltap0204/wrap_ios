//
//  RemarkViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 28/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class RemarkViewModel {
    
    let issue: Issue
    
    let service: IssueService!
    
    let isEnabled: BehaviorSubject<Bool>
    
    let showLoader: BehaviorSubject<Bool>
    
    init(issue: Issue) {
        self.issue = issue
        
        showLoader = .init(value: false)
        
        let status = issue.fields?.status?.name ?? StatusName.toDo
        isEnabled = .init(value: status == .inProgress )
        
        service = IssueService()
    }
    
    func submit(problem: String) {
        showLoader.onNext(true)
        service.add(comment: problem, issue: issue) {
            self.showLoader.onNext(false)
        }
    }
}
