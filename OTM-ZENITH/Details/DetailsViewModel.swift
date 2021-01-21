//
//  DetailsViewModel.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 09/01/20.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import Foundation
import RxSwift
import SwiftyJSON

class DetailsViewModel {
    
	let title: String
	
    let details: String
    
    let issue: Issue
    
    let showLoader: BehaviorSubject<Bool>
    
    let service: IssueService!
    
	init(title: String = "", issue: Issue) {
		self.title = title
		
        self.issue = issue
        
        self.service = IssueService()
		
		var tempDescription = ""
		if let contents = issue.fields?.fieldsDescription?.content {
			for content in contents {
				let paragraph = DetailsViewModel.getSubContent(content: content)
				
				if !paragraph.isEmpty {
					if tempDescription.isEmpty {
						tempDescription = paragraph
					} else {
						tempDescription += "\n" + paragraph
					}
				} else {
					tempDescription += "\n"
				}
			}
		}
		details = tempDescription

        showLoader = .init(value: false)
        
    }
    
    func makeTemplate() {
        showLoader.onNext(true)
        service.add(comment: "@Arnaud, can you please evaluate this to be a template?", issue: issue) {
            
            self.showLoader.onNext(false)
        }
    }
	
	
	class func getSubContent(content: DescriptionContent) -> String {
		var text = ""
		if content.content != nil {
			//fluppycontent
			for subContent in content.content! {
				if subContent.text != nil {
					if text.isEmpty {
						text = subContent.text!
					} else {
						text += subContent.text!
					}
					
				} else if subContent.content != nil {
					//TentacledContent
					for content1 in subContent.content! {
						if content1.content != nil {
//							StickyContent
							for stickyContent in content1.content! {
								if stickyContent.text != nil {
									if text.isEmpty {
										text = stickyContent.text!
									} else {
										text += stickyContent.text!
									}
								} else if stickyContent.content != nil {
//									IndigoContent
									for indigoContent in stickyContent.content! {
										if indigoContent.text != nil {
											if text.isEmpty {
												text = indigoContent.text!
											} else {
												text += indigoContent.text!
											}
										}
									}
								}
							}
						}
					}
				}
			}
		}
		return text
	}
	
}
