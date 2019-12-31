//
//  IssueService.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation

class IssueService {
    
    var client: APIClient
    let cloudId = "0322c746-c9ad-4bf8-8033-022305956776"
    
    init() {
        client = APIClient()
    }
    
    func fetch(date: Date, completion: @escaping ([Issue]?) -> Void) {
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "y-M-d"
        let dateString = dateFormatter.string(from: date)
        
        let jql = "?fields=*all&jql=assignee=currentUser()"//%20AND%20duedate=" + dateString
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
    
    func update(status: StatusName, issue: Issue, comment: String, completion: @escaping () -> Void) {
        
        let id: Int
        
        switch status {
        case .toDo:
            id = 11
        case .inProgress:
            id = 21
        case .done:
            id = 31
        }
        
        let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issue.id!)/transitions"
        
        let params = ["transition": ["id": id]]
        
        let data = try? JSONEncoder().encode(params)
        
        client.post(url: url,
                   data: data!,
                   completion: { (result) in
                    

                    self.add(comment: comment, issue: issue) {
                        
                        completion()
                    }
        })
        
        
    }
    
    func add(comment: String, issue: Issue, completion: @escaping () -> Void) {
        
        let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issue.id!)/comment"
        
        let body = Body(
            content: [
                BodyContent(
                    content: [
                        PurpleContent(text: comment, type: .text, attrs: nil)
                    ],
                    type: .paragraph
                )
            ],
            type: .doc,
            version: 1
        )
        
        let params = CommentElement(commentSelf: nil, id: nil, author: nil, body: body, updateAuthor: nil, created: nil, updated: nil, jsdPublic: nil)
            
        let data = try? JSONEncoder().encode(params)
        
        client.post(url: url,
                   data: data!,
                   completion: { (result) in
                    
                    completion()
        })
    }
}
