//
//  JobListViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
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
           // self.title.onNext(title)
        }
    }
    
    var jobs: BehaviorSubject<[Job]>
    var title: BehaviorSubject<String>
    var showLoader: BehaviorSubject<Bool>
    var hasJobs: BehaviorSubject<Bool>
    
    var issues = [Issue]()
    
    init(service: IssueService) {
        self.service = service
        
//        renewAccessToken()
        jobs = BehaviorSubject(value: [])
        
        let df = DateFormatter()
        df.dateStyle = .long
        let title = df.string(from: date)
        self.title = BehaviorSubject(value: title)
        
        hasJobs = BehaviorSubject(value: true)
        
        showLoader = BehaviorSubject(value: false)
        fetchIssues(searchString: "")
    }
    
    func loadNextDate(searchStr:String) {
        date.addTimeInterval(secondsInDay)
        fetchIssues(searchString: searchStr)
    }
    
    func loadPrevDate(searchStr:String) {
        date.addTimeInterval(-secondsInDay)
        fetchIssues(searchString: searchStr)
    }
    
    func loadFilterData(searchStr:String) {
        fetchIssues(searchString: searchStr)
    }
    
    func loadDate(date: Date,searchStr:String) {
        self.date = date
        self.title.onNext("")
        fetchIssues(searchString:searchStr)
    }
    
    func fetchIssues(searchString:String) {
        
        jobs.onNext([])
        showLoader.onNext(true)
        hasJobs.onNext(true)
        
        service.fetch(date: date,key: searchString) { [weak self] (result) in

            self?.showLoader.onNext(false)
            
            if let issues = result {
                
                
                let df = DateFormatter()
                df.dateStyle = .long
                let title = df.string(from: self?.date ?? Date())
                self?.title.onNext(title)
                self?.issues = issues
                var issueList = issues;
                if(searchString != ""){
                    issueList = issues.filter { "\($0.key ?? ""): \($0.fields?.summary ?? "")".starts(with: searchString)}
                }
                
                self?.issues =  issueList
                let jobs = issueList.map({
                    
                    Job(
                        id: $0.id ?? "",
                        key: $0.key ?? "",
                        summary: "\($0.key ?? ""): \($0.fields?.summary ?? "")",
                        location: $0.fields?.customfield10061 ?? "",
                        client: $0.fields?.customfield10056 ?? "",
                        duedate: $0.fields?.duedate ?? "",
                        updated: $0.fields?.updated ?? "",
                        statusColor: self?.color(for: $0.fields?.status)
                    )
                })
                
                self?.hasJobs.onNext(jobs.count>0)
                self?.jobs.onNext(jobs)
                
            }
        }
    }
    
    func color(for status: Status?) -> String? {
        let color: String?
        switch status?.id {
        case "10030":
            color = "statusToDo"
            break
        case "10031":
            color = "statusInProgress"
            break
        case "10124":
            color = "statusProblem"
            break
        case "10032":
            color = "statusDone"
            break
        default:
            color = nil
            break
        }
        /*switch status {
        case .done, .Terminé, .Terminée:
            color = "statusDone"
        case .inProgress, .enCours, .problem:
            color = "statusInProgress"
        case .toDo, .aFaire, .aaFaire:
            color = "statusToDo"
        default:
            color = nil
        }*/
        return color
    }
}
