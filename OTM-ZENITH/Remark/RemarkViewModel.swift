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
    
    let washInstructions: BehaviorSubject<Bool>
    let vehicleLate: BehaviorSubject<Bool>
    let vehicleDirty: BehaviorSubject<Bool>
    let railroadCrossing: BehaviorSubject<Bool>
    let positionNotClear: BehaviorSubject<Bool>
    let redWhiteNotMounted: BehaviorSubject<Bool>
    let GPSnotCorrect: BehaviorSubject<Bool>
    let plateHolder: BehaviorSubject<Bool>
    let interventionOfCarglass: BehaviorSubject<Bool>
    let interventionOfTiers: BehaviorSubject<Bool>
    let onlyRemoveTheLogo: BehaviorSubject<Bool>
    let removeMoreThanLogo: BehaviorSubject<Bool>
    let carPainted: BehaviorSubject<Bool>
    
    let infrabelContainer: BehaviorSubject<Bool>
    let fluviusContainer: BehaviorSubject<Bool>
    
    
    init(issue: Issue) {
        self.issue = issue
        
        showLoader = .init(value: false)
        
        let status = issue.fields?.status?.statusCategory?.id ?? StatusCategoryId.toDo
        isEnabled = .init(value: status == .inProgress )
        
        washInstructions = .init(value: issue.fields?.customfield10080?.contains(where: { $0.id == "10116" }) ?? false)
        vehicleLate = .init(value: issue.fields?.customfield10080?.contains(where: { $0.id == "10328" }) ?? false)
        vehicleDirty = .init(value: issue.fields?.customfield10080?.contains(where: { $0.id == "10304" }) ?? false)
        
        railroadCrossing = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10203" }) ?? false)
        positionNotClear = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10204" }) ?? false)
        redWhiteNotMounted = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10235" }) ?? false)
        GPSnotCorrect = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10236" }) ?? false)

        plateHolder = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10329" }) ?? false)
        interventionOfCarglass = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10364" }) ?? false)
        interventionOfTiers = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10365" }) ?? false)
        onlyRemoveTheLogo = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10366" }) ?? false)
        removeMoreThanLogo = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10367" }) ?? false)
        carPainted = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10368" }) ?? false)
        
        infrabelContainer = .init(value: (issue.fields?.customfield10128 == nil))
        fluviusContainer = .init(value: (issue.fields?.customfield10105 == nil))
        
        service = IssueService()
    }
    
    func submit(problem: String) {
        showLoader.onNext(true)
        service.add(comment: problem, issue: issue) {
            self.showLoader.onNext(false)
        }
    }
	
	func update(washInstructions: Bool, vehicleLate: Bool, vehicleDirty: Bool, fluviusContainer: Bool, railroadCrossing: Bool, positionNotClear: Bool, redWhiteNotMounted: Bool, GPSnotCorrect: Bool, infrabelContainer: Bool, plateHolder: Bool, interventionOfCarglass: Bool, interventionOfTiers: Bool, onlyRemoveTheLogo: Bool, removeMoreThanLogo: Bool, carPainted: Bool) {
		service.updateRemarks(issue: issue, washInstructions: washInstructions, vehicleLate: vehicleLate, vehicleDirty: vehicleDirty, fluviusContainer: fluviusContainer, railroadCrossing: railroadCrossing, positionNotClear: positionNotClear, redWhiteNotMounted: redWhiteNotMounted, GPSnotCorrect: GPSnotCorrect, infrabelContainer: infrabelContainer, plateHolder: plateHolder, interventionOfCarglass: interventionOfCarglass, interventionOfTiers: interventionOfTiers, onlyRemoveTheLogo: onlyRemoveTheLogo, removeMoreThanLogo: removeMoreThanLogo, carPainted: carPainted) {
			
		}

	}
}
