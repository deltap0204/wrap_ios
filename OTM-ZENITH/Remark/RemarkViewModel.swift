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
        
        let status = issue.fields?.status?.name ?? StatusName.toDo
        isEnabled = .init(value: status == .inProgress )
        
        washInstructions = .init(value: issue.fields?.customfield10080?.contains(where: { $0.id == "10116" }) ?? false)
        vehicleLate = .init(value: issue.fields?.customfield10080?.contains(where: { $0.id == "10328" }) ?? false)
        vehicleDirty = .init(value: issue.fields?.customfield10080?.contains(where: { $0.id == "10304" }) ?? false)
        
        railroadCrossing = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10203" }) ?? false)
        positionNotClear = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10204" }) ?? false)
        redWhiteNotMounted = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10235" }) ?? false)
        GPSnotCorrect = .init(value: issue.fields?.customfield10128?.contains(where: { $0.id == "10236" }) ?? false)
        
        plateHolder = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10145" }) ?? false)
        interventionOfCarglass = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10146" }) ?? false)
        interventionOfTiers = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10146" }) ?? false)
        onlyRemoveTheLogo = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10146" }) ?? false)
        removeMoreThanLogo = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10146" }) ?? false)
        carPainted = .init(value: issue.fields?.customfield10105?.contains(where: { $0.id == "10331" }) ?? false)
        
        infrabelContainer = .init(value: (issue.fields?.issuetype?.name == "Infrabel Level Crossing"))
        fluviusContainer = .init(value: (issue.fields?.issuetype?.name == "Fluvius Vehicle"))
        
        service = IssueService()
    }
    
    func submit(problem: String) {
        showLoader.onNext(true)
        service.add(comment: problem, issue: issue) {
            self.showLoader.onNext(false)
        }
    }
}
