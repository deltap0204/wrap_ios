//
//  AttachmentService.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 22/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation

class AttachmentService {
    
    var client: APIClient!
    
    init(client: APIClient) {
        self.client = client
    }
    
    func uploadImage(data: Data, issueIdOrKey: String, completion: @escaping (Attachment?) -> Void) {
        let cloudId = "0322c746-c9ad-4bf8-8033-022305956776"
        let url = "https://api.atlassian.com/ex/jira/\(cloudId)/rest/api/3/issue/\(issueIdOrKey)/attachments"
        client.upload(url: url, image: data) { (result) in
            let object = try! JSONDecoder().decode([Attachment].self, from: result as! Data)
            
            completion(object.first)
        }
    }
}
