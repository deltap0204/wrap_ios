//
//  VehicleViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 22/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import RxSwift

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
    let showSuccessMessage: PublishSubject<String>
    
    init(issue: Issue) {
        self.issue = issue
        
        license = issue.fields?.customfield10059 ?? ""
        objectID = issue.fields?.customfield10058 ?? ""
        brand = issue.fields?.customfield10062 ?? ""
        type = issue.fields?.customfield10063 ?? ""
        km = String(issue.fields?.customfield10083 ?? 0)
        vehicleOnTime = ""
        vehicleDirty = ""
        washInstructionApplied = ""
        
        showLoader = .init(value: false)
        
        showSuccessMessage = .init()
        
        service = IssueService()
    }
    
    
    func submit(problem: String) {
        showLoader.onNext(true)
        let remark = "@Arnaud: a remark was added\n\(problem)"
        service.update(status: .problem, issue: issue, comment: remark) {
            self.showLoader.onNext(false)
            self.showSuccessMessage.onNext("Sent successfully")
        }
        
    }
	
	func updateVehicleInfo(license_plate: String, object_id: String, brand: String, type: String, km: Double) {
		showLoader.onNext(true)
		service.updateVehicleInfo(issue: issue, license_plate: license_plate, object_id: object_id, brand: brand, type: type, km: km) {
			self.showLoader.onNext(false)
			self.showSuccessMessage.onNext("Update successfully")
		}
	}
}
