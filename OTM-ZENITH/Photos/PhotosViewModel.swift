//
//  PhotosViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import UIKit
import OAuthSwift
import RxSwift

class PhotosViewModel {
    
    struct Photo {
        let thumb: String
        let original: String
    }
    
    var photos: BehaviorSubject<[Photo]>!
    
    let issue: Issue
    
    var attachmentService: AttachmentService!
    let client = APIClient()
    
    init(issue: Issue) {
        self.issue = issue
        
        let photos = issue.fields?.attachment?.map({ self.photo(from: $0) }) ?? []
        self.photos = .init(value: photos)
    }
    
    func photo(from attachment: Attachment) -> Photo {
        return Photo(thumb: attachment.thumbnail ?? "", original: attachment.content ?? "")
    }
    
    func upload(image: UIImage) {
        attachmentService = AttachmentService(client: client)
        let data = image.jpegData(compressionQuality: 0.7)!
        attachmentService.uploadImage(data: data, issueIdOrKey: issue.id!) { [weak self] (result) in
            
            let photo = self?.photo(from: result!)
            var newPhotos = try? self?.photos.value() ?? []
            newPhotos?.append(photo!)
            self?.photos.onNext(newPhotos!)
        }
    }
}
