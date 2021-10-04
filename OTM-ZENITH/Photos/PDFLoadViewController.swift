//
//  PDFLoadViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 04/10/21.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import PDFKit

private var kElementHorizontalMargin: CGFloat { return 20 }
private var kElementHeight: CGFloat { return 40 }
private var kElementWidth: CGFloat { return 50 }
private var kElementBottomMargin: CGFloat { return 10 }

class PDFLoadViewController: UIViewController {
    var pdfLink: String!
    lazy var cancelButton: UIButton = {
        let cancelButton = UIButton(frame: CGRect.zero)
        cancelButton.setImage(UIImage.cancelIcon(size: CGSize(width: 15, height: 15), color: UIColor.white), for: UIControl.State())
        cancelButton.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: UIControl.Event.touchUpInside)
        cancelButton.contentHorizontalAlignment = .center
        cancelButton.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return cancelButton
    }()
    
    lazy var cancelButtonBGView: UIView = {
        let bgView = UIView(frame: CGRect(x: 15, y: 35, width: 25, height: 25))
        bgView.backgroundColor = UIColor.black
        bgView.alpha = 0.25
        bgView.layer.cornerRadius = 4
        return bgView
    }()

    @IBOutlet weak var pdfLoadView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(cancelButtonBGView)
        view.addSubview(cancelButton)
        
        let pdfView = PDFView(frame: self.pdfLoadView.bounds)
        pdfView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.pdfLoadView.addSubview(pdfView)
        
        // Fit content in PDFView.
        pdfView.autoScales = true
        
        // Load Sample.pdf file from app bundle.
//        let fileURL = URL(string: pdfLink!)
//        pdfView.document = PDFDocument(url: fileURL!)
        APIClient().get11(url: pdfLink, params: [:]) { response in
            pdfView.document = PDFDocument(data: response as! Data)
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        // Layout subviews
        let buttonHeight: CGFloat = kElementHeight
        let buttonWidth: CGFloat = kElementWidth

        cancelButton.frame = CGRect(origin: CGPoint(x: 20, y: 40), size: CGSize(width: buttonWidth, height: buttonHeight))
        cancelButtonBGView.frame = CGRect(origin: CGPoint(x: 18, y: 38), size: CGSize(width: buttonWidth + 4, height: buttonHeight + 4))
        
    }
    
    @objc
    func cancelButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func bottomButtonsVerticalPosition() -> CGFloat {
        return view.bounds.height - kElementHeight - kElementBottomMargin
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
