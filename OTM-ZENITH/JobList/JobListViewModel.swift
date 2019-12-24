//
//  JobListViewModel.swift
//  OTM-ZENITH
//
//  Created by Ram Suthar on 20/12/19.
//  Copyright © 2019 Ram Suthar. All rights reserved.
//

import Foundation
import OAuthSwift
import RxSwift

class JobListViewModel {
    
    let secondsInDay = TimeInterval(60*60*24)
    
    struct Job: Codable {
        let id: String
        let key: String
        let summary: String
        let location: String
        let client: String
        let duedate: String
        let updated: String
        let statusColor: String?
    }
    
    let service: IssueService
    var date = Date() {
        didSet {
            let df = DateFormatter()
            df.dateStyle = .long
            let title = df.string(from: date)
            self.title.onNext(title)
        }
    }
    
    var jobs: BehaviorSubject<[Job]>
    var title: BehaviorSubject<String>
    var showLoader: BehaviorSubject<Bool>
    
    var issues = [Issue]()
    
    init(service: IssueService) {
        self.service = service
        
//        renewAccessToken()
        jobs = BehaviorSubject(value: [])
        
        let df = DateFormatter()
        df.dateStyle = .long
        let title = df.string(from: date)
        self.title = BehaviorSubject(value: title)
        
        showLoader = BehaviorSubject(value: false)
        fetchIssues()
    }
    
    func loadNextDate() {
        date.addTimeInterval(secondsInDay)
        fetchIssues()
    }
    
    func loadPrevDate() {
        date.addTimeInterval(-secondsInDay)
        fetchIssues()
    }
    
    func fetchIssues() {
        
        jobs.onNext([])
        showLoader.onNext(true)
        
        service.fetch(date: date) { [weak self] (result) in

            self?.showLoader.onNext(false)
            
            if let issues = result {
                self?.issues = issues
                let jobs = issues.map({
                    
                    Job(
                        id: $0.id!,
                        key: $0.key!,
                        summary: $0.fields?.summary ?? "",
                        location: $0.fields?.customfield10061 ?? "",
                        client: $0.fields?.customfield10056 ?? "",
                        duedate: $0.fields?.duedate ?? "",
                        updated: $0.fields?.updated ?? "",
                        statusColor: self?.color(for: $0.fields?.status?.name)
                    )
                })
                
                self?.jobs.onNext(jobs)
            }
        }
    }
    
    func color(for status: StatusName?) -> String? {
        let color: String?
        switch status {
        case .done:
            color = "statusDone"
        case .inProgress:
            color = "statusInProgress"
        case .toDo:
            color = "statusToDo"
        default:
            color = nil
        }
        return color
    }
}
