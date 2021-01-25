//
//  String+Extension.swift
//  OTM-ZENITH
//
//  Created by Nam Phong Nguyen on 25/01/2021.
//  Copyright © 2021 Ram Suthar. All rights reserved.
//

import UIKit

extension String {
	var html2AttributedString: NSAttributedString? {
		guard
			let data = data(using: String.Encoding.utf8)
			else { return nil }
		do {
			let attString = try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType : NSAttributedString.DocumentType.html, NSAttributedString.DocumentReadingOptionKey.characterEncoding:  String.Encoding.utf8.rawValue], documentAttributes: nil)
			
			let attFont = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)]
			let mutableString = NSMutableAttributedString(attributedString: attString)
			let nsrange = NSRange(location: 0, length: attString.length)
			mutableString.addAttributes(attFont, range: nsrange)
			
			return mutableString
			
		} catch let error as NSError {
			print(error.localizedDescription)
			return  nil
		}
	}
	
	func addCssStyle() -> String {
		do {
			let cssString = try String(contentsOf: Bundle.main.url(forResource: "WebViewStyle", withExtension: "css")!, encoding: .utf8)
			
			return String(format: "<html><head><meta name=\"viewport\" content=\"user-scalable=no\"/><style>%@</style></head><body style='margin:8; padding:8; font-size: 16; font-family: HelveticaNeue; color:#ffffff'>%@</body></html>",cssString, self)
		} catch _ {
			return self
		}
	}
}
