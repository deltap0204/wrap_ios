//
//  VehicleViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 22/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation

class VehicleViewModel {
    
    let license: String
    let objectID: String
    let brand: String
    let type: String
    let km: String
    let vehicleOnTime: String
    let vehicleDirty: String
    let washInstructionApplied: String
    
    let issue: Issue
    
    let service: IssueService!
    
    let showLoader: BehaviorSubject<Bool>
    
    init(issue: Issue) {
        self.issue = issue
        
        license = issue.fields?.customfield10059 ?? ""
        objectID = issue.fields?.customfield10058 ?? ""
        brand = issue.fields?.customfield10062 ?? ""
        type = issue.fields?.customfield10063 ?? ""
        km = String(issue.fields?.customfield10082 ?? 0)
        vehicleOnTime = ""
        vehicleDirty = ""
        washInstructionApplied = ""
        
        showLoader = .init(value: false)
        
        service = IssueService()
    }
    
    func submit(problem: String) {
        showLoader.onNext(true)
        let remark = "@Arnaud: a remark was added\n\(problem)"
        service.add(comment: remark, issue: issue) {
            self.showLoader.onNext(false)
        }
    }
}
