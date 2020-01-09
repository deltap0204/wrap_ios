//
//  JobViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation

class JobViewModel {
    
    let title: String
    let address: String
    let contact: String
    
    let hasPhone: Bool
    let phone: String
    let hasLocation: Bool
    let latitude: Double
    let longitude: Double
    
    let issue: Issue
    
    init(issue: Issue) {
        self.issue = issue
        
        title = issue.fields?.summary ?? ""
        address = issue.fields?.customfield10061 ?? ""
        
        phone = issue.fields?.customfield10065 ?? ""
        hasPhone = !phone.isEmpty

        let person = issue.fields?.customfield10079 ?? ""
        contact = "\(person) - \(phone)"
        
        let location = issue.fields?.customfield10101?.components(separatedBy: ",")
        let lat1 = location?[0] ?? ""
        let lng1 = location?[1] ?? ""
        let latitude =  Double(lat1)
        let longitude =  Double(lng1)
        
        hasLocation = (latitude != nil && longitude != nil)
        
        self.latitude = latitude ?? 0
        self.longitude = longitude ?? 0
        
    }
}
