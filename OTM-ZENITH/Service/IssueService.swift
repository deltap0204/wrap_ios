//
//  IssueService.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 20/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation

func stringify(json: Any, prettyPrinted: Bool = false) -> String {
    var options: JSONSerialization.WritingOptions = []
    if prettyPrinted {
      options = JSONSerialization.WritingOptions.prettyPrinted
    }

    do {
      let data = try JSONSerialization.data(withJSONObject: json, options: options)
      if let string = String(data: data, encoding: String.Encoding.utf8) {
        return string
      }
    } catch {
      print(error)
    }

    return ""
}

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
//        let jql = "?fields=*all&jql=project%20%3D%20WT%20AND%20assignee=david.mandelier"
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
                    if let dt = result as? Data {
                        let resURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent("issue_response.txt")
                        do {
                            try dt.write(to: resURL)
                            print(resURL.path)
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    let str = String(decoding: result as! Data, as: UTF8.self)
                    let object = try! JSONDecoder().decode(SearchIssueResponse.self, from: result as! Data)
                    
                    let issues = object.issues
                    
                    completion(issues)
        })
    }
    
    func fetchIssue(issueId: String, completion: @escaping (Issue) -> Void) {
        let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issueId)"
        client.get(url: url,
                   params: [:],
                   completion: { (result) in
                    let object = try! JSONDecoder().decode(Issue.self, from: result as! Data)
                    print("object \(object)")
                    completion(object)
        })
    }
    
    func update(status: StatusCategoryId, issue: Issue, comment: String, completion: @escaping () -> Void) {
        
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
        //let commentsCount = (issue.fields?.worklog?.comments ?? []).count
        var googleMapURL = "https://www.google.com/maps/search/?api=1"
        var locationString = ""
        if let location = LocationService.location {
            googleMapURL = "https://www.google.com/maps/embed/v1/view?key=AIzaSyAQ9y8k71ddIOpT1pf1AcHZ0ahAvzqAKcA&center=\(location.latitude),\(location.longitude)&zoom=18"
                //googleMapURL = googleMapURL + "&query=\(location.latitude),\(location.longitude))"
            locationString = "\(location.latitude),\(location.longitude)"
            
        }
        let params: [String: Any] = ["transition": ["id": "\(id)"]]
        
        //let params: [String: [String: String]] = ["transition": ["id": "\(id)"],"fields":["customfield_10132": googleMapURL]]
           
        let data: Data? = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
        self.updateMetaData(googleURL:googleMapURL,location:locationString,issue: issue) {
            self.client.post(url: url,
                              data: data!,
                              completion: { (result) in
                                   self.add(comment: comment, issue: issue) {

                                       completion()
                                   }
                   })
        }
        
       
        
        
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
    
    func updateMetaData( googleURL:String,location:String,issue: Issue, completion: @escaping () -> Void) {
        
              let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/2/issue/\(issue.key!)"
              let params = ["fields":["customfield_10132":googleURL]]
              let data: Data? = try? JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
              client.put(url: url,
                         params: params,
                           completion: { (result) in
                        completion()
                            
                })
              
    }
}
