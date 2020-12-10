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
        
		phone = (issue.fields?.customfield10065 ?? "").filter("0123456789".contains)
        hasPhone = !phone.isEmpty

        let person = issue.fields?.customfield10079 ?? ""
        contact = "\(person) - \(phone)"
        var locationURL = issue.fields?.customfield_10132
        locationURL = locationURL?.replacingOccurrences(of: "https://www.google.com/maps/embed/v1/view?key=AIzaSyAQ9y8k71ddIOpT1pf1AcHZ0ahAvzqAKcA&center=", with: "")
        locationURL = locationURL?.replacingOccurrences(of: "&zoom=18", with: "")
        if let location = locationURL?.components(separatedBy: ","), location.count == 2 {
            let lat1 = location[0]
            let lng1 = location[1]
            let latitude =  Double(lat1)
            let longitude =  Double(lng1)
            self.latitude = latitude ?? 0
            self.longitude = longitude ?? 0
            
            hasLocation = true
        }
        else {
            self.latitude = 0
            self.longitude = 0
            hasLocation = false
        }
        
    }
}
