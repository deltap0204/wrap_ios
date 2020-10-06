//
//  UIViewExtension.swift
//  OTM-ZENITH
//
//  Created by Nam Phong Nguyen on 10/6/20.
//  Copyright © 2020 Ram Suthar. All rights reserved.
//

import UIKit

extension UIView {
	
	@IBInspectable var borderColor: UIColor {
		get {
			return UIColor.clear
		}
		set (color) {
			self.layer.borderColor = color.cgColor
		}
	}
	
	@IBInspectable var borderWidth: CGFloat {
		get {
			return 0
		}
		set (width) {
			self.layer.borderWidth = width
		}
	}
	
	@IBInspectable var cornerRadius: CGFloat {
		get {
			return 0
		}
		set (width) {
			self.layer.cornerRadius = width
			self.layer.masksToBounds = true
		}
	}
	
	internal func fillSuperView(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
		guard let superview = superview else { return }
		self.translatesAutoresizingMaskIntoConstraints = false
		self.topAnchor.constraint(equalTo: superview.topAnchor, constant: top).isActive = true
		self.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: -bottom).isActive = true
		self.leadingAnchor.constraint(equalTo: superview.leadingAnchor, constant: left).isActive = true
		self.trailingAnchor.constraint(equalTo: superview.trailingAnchor, constant: -right).isActive = true
	}
	
	func clearConstraints() {
		for subview in self.subviews {
			subview.clearConstraints()
		}
		self.removeConstraints(self.constraints)
	}
	
	
	func roundCorners(corners: UIRectCorner, radius: CGFloat) {
		let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		mask.fillColor = UIColor.red.cgColor
		mask.strokeColor = UIColor.clear.cgColor
		layer.mask = mask
	}
	
	func addShadow(cornerRadius: CGFloat = 5.0) {
		self.layer.cornerRadius = cornerRadius
		self.layer.shadowColor = UIColor.black.cgColor
		self.layer.shadowOffset = CGSize(width: 0, height: 4)
		self.layer.shadowOpacity = 0.2
		self.layer.shadowRadius = cornerRadius
	}
	
	
}
