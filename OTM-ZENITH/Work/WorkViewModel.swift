//
//  WorkViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 28/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import RxSwift

class WorkViewModel {
    
    let enableStartJob: BehaviorSubject<Bool>
    let enableStopJob: BehaviorSubject<Bool>
    let enableCloseJob: BehaviorSubject<Bool>
    let enableStartRoute: BehaviorSubject<Bool>
    let enableStopRoute: BehaviorSubject<Bool>
    
    let showLoader: BehaviorSubject<Bool>
    
    let issue: Issue
    
    let service: IssueService!
    
    let locationService: LocationService!
    
    init(issue: Issue) {
        
        self.issue = issue
        
        self.service = IssueService()
        
        let status = issue.fields?.status?.statusCategory?.id ?? .toDo
        enableStartJob = .init(value: status == .toDo)
        enableStopJob = .init(value: status == .inProgress)
        enableCloseJob = .init(value: status != .done)
        enableStartRoute = .init(value: status != .done)
        enableStopRoute = .init(value: status != .done)
        
        showLoader = .init(value: false)
        
        locationService = LocationService()
        locationService.getLocation { (_) in
            
        }
    }
    
    func startJob() {
        showLoader.onNext(true)
        service.update(status: .inProgress, issue: issue, comment: jobComment(for: .inProgress)) {
            self.showLoader.onNext(false)
            self.enableStartJob.onNext(false)
            self.enableStopJob.onNext(true)
        }
    }
    
    
    
    
    func stopJob() {
        showLoader.onNext(true)
        service.update(status: .inProgress, issue: issue, comment: jobComment(for: .toDo)) {
            self.showLoader.onNext(false)
            
            self.enableStartJob.onNext(true)
            self.enableStopJob.onNext(false)
        }
    }
    
    func closeJob() {
        showLoader.onNext(true)
        service.update(status: .done, issue: issue, comment: jobComment(for: .done)) {
            self.showLoader.onNext(false)
            
            self.enableStartJob.onNext(false)
            self.enableStopJob.onNext(false)
            self.enableCloseJob.onNext(false)
        }
    }
    
    func startRoute() {
        showLoader.onNext(true)
        service.add(comment: routeComment(for: .inProgress), issue: issue) {
            self.showLoader.onNext(false)
        }
    }
    
    func stopRoute() {
        showLoader.onNext(true)
        
        service.add(comment: routeComment(for: .done), issue: issue) {
            self.showLoader.onNext(false)
        }
    }
    
    func jobComment(for status: StatusCategoryId) -> String {

        let state: String
        
        switch status {
        case .toDo:
            state = "stopped"
        case .inProgress:
            state = "started"
        case .done:
            state = "completed"
        }
        
        let df = DateFormatter()
        df.dateFormat = "hh:mm:ss"
        let time = df.string(from: Date())
        
        let cordinates = cordinateString()
        
        var googleMapURL = "https://www.google.com/maps/search/?api=1"
        if let location = LocationService.location {
                   googleMapURL = googleMapURL + "&query=\(location.latitude),\(location.longitude)"
        }
        
        return "I \(state) the job at \(time) with geo-coordinates : \(googleMapURL)"
        
    }
    
    func routeComment(for status: StatusCategoryId) -> String {

        let state: String
        
        switch status {
        case .toDo:
            state = "stopped"
        case .inProgress:
            state = "started"
        case .done:
            state = "completed"
        }
        
        let df = DateFormatter()
        df.dateFormat = "hh:mm:ss"
        let time = df.string(from: Date())
        
        let cordinates = cordinateString()
        
        return "I \(state) my route at \(time) with geo-coordinates : \(cordinates)"
        
    }
    
    func cordinateString() -> String {
        
        var cordinates = ""
        if let location = LocationService.location {
            cordinates = "\(location.latitude), \((location.longitude))"
        }
        
        return cordinates
    }
}
