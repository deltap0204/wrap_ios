//
//  IssueService.swift
//  OTM-ZENITH
//
//  Created by Ram Suthar on 20/12/19.
//  Copyright © 2019 Ram Suthar. All rights reserved.
//

import Foundation

class IssueService {
    
    var client: APIClient!
    
    func fetch(date: Date, completion: @escaping ([Issue]?) -> Void) {
        client = APIClient()
        
        let cloudId = "0322c746-c9ad-4bf8-8033-022305956776"
        let jql = "?fields=*all&jql=assignee=currentUser()"
        let params: [String: Any] = [:]
//        [
//            "jql": jql,
//            "fields": ["summary","assignee","status"],
//            "maxResults": 5
//        ]
        
//        let url = "https://api.atlassian.com/oauth/token/accessible-resources"
        let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/search\(jql)"
        client.get(url: url,
                   params: params,
                   completion: { (result) in
                    
                    let object = try! JSONDecoder().decode(SearchIssueResponse.self, from: result as! Data)
                    
                    let issues = object.issues
                    
                    completion(issues)
        })
    }
}
