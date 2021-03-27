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
	var routeStatus: BehaviorSubject<Bool>
    
    let showLoader: BehaviorSubject<Bool>
    
    let issue: Issue
    
    let service: IssueService!
    
    let locationService: LocationService!
    
    init(issue: Issue) {
        
        self.issue = issue
        
        self.service = IssueService()
        
//        let status = issue.fields?.status?.statusCategory?.id ?? .toDo
		
		var status: StatusCategoryId = .toDo
		if let status_id = issue.fields?.status?.id {
			if status_id == "10030" {
				status = .toDo
			} else if status_id == "10031" {
				status = .inProgress
			} else if status_id == "10124" {
				status = .problem
			} else if status_id == "10032" {
				status = .done
			}
		}
		
        enableStartJob = .init(value: status == .toDo)
        enableStopJob = .init(value: status == .inProgress)
        enableCloseJob = .init(value: status != .done)
        enableStartRoute = .init(value: status != .done)
        enableStopRoute = .init(value: status != .done)
		routeStatus = .init(value: false)
        
        showLoader = .init(value: false)
        
        locationService = LocationService()
        locationService.getLocation { (_) in
            
        }
		getRouteStatus()
		
    }
	
	func getRouteStatus() {
		service.getRouteStatus(issue: issue) { (started) in
			self.routeStatus.onNext(started)
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
			self.service.setRoute(isStart: true, issue: self.issue) {
				self.routeStatus.onNext(true)
			}
        }
		
    }
    
    func stopRoute() {
        showLoader.onNext(true)
        
        service.add(comment: routeComment(for: .done), issue: issue) {
            self.showLoader.onNext(false)
			self.service.setRoute(isStart: false, issue: self.issue) {
				self.routeStatus.onNext(false)
			}
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
        case .problem:
            state = "problem"
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
        case .problem:
            state = "problem"
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
