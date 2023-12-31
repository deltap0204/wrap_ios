//
//  JIRAImageProvider.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 22/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import Foundation
import Kingfisher

struct JIRAImageProvider: ImageDataProvider {
    var cacheKey: String { return url }
    let url: String
    
    let webClient = WebClient()
    
    init(url: String) {
        self.url = url
    }
    
    func data(handler: @escaping (Result<Data, Error>) -> Void) {
        
        webClient.handle(URL(string: url)!) { (url) in
            let downloader = ImageDownloader.default
            downloader.downloadImage(with: url!, completionHandler:  { result in
                switch result {
                case .success(let value):
                    handler(.success(value.originalData))
                case .failure(let error):
                    handler(.failure(error))
                }
            })
        }
    }
}
