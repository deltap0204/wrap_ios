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
    
    var issue: Issue
    let showLoader: BehaviorSubject<Bool>
    var attachmentService: AttachmentService!
    let client = APIClient()
    
    init(issue: Issue) {
        self.issue = issue
        showLoader = .init(value: false)
        let photos = issue.fields?.attachment?.map({ self.photo(from: $0) }) ?? []
        self.photos = .init(value: photos)
    }
    
    func photo(from attachment: Attachment) -> Photo {
        let baseUrl = "https://dji3uol75f.execute-api.eu-central-1.amazonaws.com/dev"
        let id = attachment.id ?? ""
        let filename = attachment.filename ?? ""
        let thumbPath = "/issue/getThumbnail/"
        let fullPath = "/issue/getImage/"
        let thumbUrl = baseUrl + thumbPath + id + "/" + filename
        let fullUrl = baseUrl + fullPath + id + "/" + filename
        return Photo(thumb: thumbUrl, original: fullUrl)
    }
    
    func upload(image: UIImage) {
        attachmentService = AttachmentService(client: client)
        let data = image.jpegData(compressionQuality: 0.7)!
        attachmentService.uploadImage(data: data, issueIdOrKey: issue.id!) { [weak self] (result) in
            
            var googleMapURL = "https://www.google.com/maps/search/?api=1"
            var locationString = ""
            if let location = LocationService.location {
                googleMapURL = "https://www.google.com/maps/embed/v1/view?key=AIzaSyBhiqcP_bAdHxn2PIilDhj76W7rHhQBmwE&center=\(location.latitude),\(location.longitude)&zoom=18"
                locationString = "\(location.latitude),\(location.longitude)"
                IssueService.shareInstance.updateMetaData(googleURL: googleMapURL, location: locationString, issue: self!.issue) {
                    let photo = self?.photo(from: result!)
                    var newPhotos = try? self?.photos.value() ?? []
                    newPhotos?.append(photo!)
                    self?.photos.onNext(newPhotos!)
                }
            }
        }
    }
    
    func fetchIssue(issueId: String, completion: @escaping (Issue) -> Void) {
        showLoader.onNext(true)
        IssueService().fetchIssue(issueId: issueId, completion: { newIssue in
            self.showLoader.onNext(false)
            completion(newIssue)
        })
    }
}
