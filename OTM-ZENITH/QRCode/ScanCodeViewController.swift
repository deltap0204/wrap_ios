//
//  ScanCodeViewController.swift
//  iOS_issue
//
//  Created by Freddy Mendez on 2020/02/08.
//  Copyright © 2020 Freddy Mendez. All rights reserved.
//

import UIKit


class ScanCodeViewController: SwiftQRCodeVC {

    var qrCodeBack:(_ controller:ScanCodeViewController, _ code:String)-> Void = {_,_  in }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let leftBarButton = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(leftButtonClicked))
        self.navigationItem.leftBarButtonItem = leftBarButton
        
    }

    @objc func leftButtonClicked() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func qrCodeCallBack(_ codeString: String?) {
        
        self.qrCodeBack(self, codeString ?? "")
        
    }
    
}
