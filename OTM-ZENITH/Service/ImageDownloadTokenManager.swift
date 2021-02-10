//
//  ImageDownloadTokenManager.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 10/26/20.
//  Copyright © 2020 Freddy Mendez∑. All rights reserved.
//

import UIKit
import Kingfisher

class ImageDownloadTokenManager: ImageDownloadRequestModifier {

	func modified(for request: URLRequest) -> URLRequest? {
		var request = request
		request.addValue("Bearer " + APIClient.oauthClient.client.credential.oauthToken, forHTTPHeaderField: "Authorization")
		return request
	}
}
