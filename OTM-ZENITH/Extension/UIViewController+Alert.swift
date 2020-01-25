//
//  UIViewController+Alert.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 25/01/20.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func confirm(title: String, message: String, actionHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let action = UIAlertAction(title: "Yes", style: UIAlertAction.Style.default) { _ in
            actionHandler?()
        }
        alert.addAction(action)
        if actionHandler != nil {
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    func alert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
}
