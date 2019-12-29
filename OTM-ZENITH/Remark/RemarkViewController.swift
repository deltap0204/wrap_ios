//
//  RemarkViewController.swift
//  OTM-ZENITH
//
//  Created by Freddy Mendez on 21/12/19.
//  Copyright © 2019 Freddy Mendez. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class RemarkViewController: UIViewController {

    var viewModel: RemarkViewModel!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var problem: UITextView!
    @IBOutlet var buttonEnter: UIButton!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    @IBOutlet var overlayView: UIView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        problem.layer.cornerRadius = 8
        buttonEnter.layer.cornerRadius = 8
        
        bindViewModel()
    }
    
    private func bindViewModel() {
        problem.rx.didBeginEditing
            .bind(onNext: { (_) in
                var contentInset = self.scrollView.contentInset
                contentInset.bottom = 290
                self.scrollView.contentInset = contentInset
            self.scrollView.scrollToView(view: self.problem, animated: true)
        })
        .disposed(by: disposeBag)
        
        problem.rx.didEndEditing
            .bind(onNext: { (_) in
                var contentInset = self.scrollView.contentInset
                contentInset.bottom = 0
                self.scrollView.contentInset = contentInset
        })
        .disposed(by: disposeBag)
        
        viewModel.showLoader.map({ !$0 }).bind(to: overlayView.rx.isHidden).disposed(by: disposeBag)
        
//        viewModel.showLoader.bind(to: activityIndicator.rx.isAnimating).disposed(by: disposeBag)
    }
    
    @IBAction func submit(_ sender: Any) {
        problem.resignFirstResponder()

        viewModel.submit(problem: problem.text)
        
        problem.text = ""
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

extension UIScrollView {

    // Scroll to a specific view so that it's top is at the top our scrollview
    func scrollToView(view:UIView, animated: Bool) {
        if let origin = view.superview {
            // Get the Y position of your child view
            let childStartPoint = origin.convert(view.frame.origin, to: self)
            // Scroll to a rectangle starting at the Y of your subview, with a height of the scrollview
//            self.scrollRectToVisible(CGRect(x:0, y:childStartPoint.y,width: 1,height: self.frame.height), animated: animated)
            setContentOffset(CGPoint(x: 0, y: childStartPoint.y - 20), animated: animated)
        }
    }

}
