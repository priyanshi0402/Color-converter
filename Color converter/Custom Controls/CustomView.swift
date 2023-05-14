//
//  CustomView.swift
//  Color converter
//
//  Created by PRIYANSHI on 30/04/23.
//

import Foundation
import UIKit

class CustomView: UIView {

    // MARK: Set View cornerRadius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    // MARK: Set View borderWidth
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    // MARK: Set View borderColor
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }
}

extension UIView {
    func roundCorners(radius: CGFloat = 10, corners: UIRectCorner = .allCorners) {
        //        self.clipsToBounds = true
        self.layer.cornerRadius = radius
        if #available(iOS 11.0, *) {
            var arr: CACornerMask = []
            let allCorners: [UIRectCorner] = [.topLeft, .topRight, .bottomLeft, .bottomRight, .allCorners]
            for corn in allCorners where (corners.contains(corn)) {
                switch corn {
                case .topLeft:
                    arr.insert(.layerMinXMinYCorner)
                case .topRight:
                    arr.insert(.layerMaxXMinYCorner)
                case .bottomLeft:
                    arr.insert(.layerMinXMaxYCorner)
                case .bottomRight:
                    arr.insert(.layerMaxXMaxYCorner)
                case .allCorners:
                    arr.insert(.layerMinXMinYCorner)
                    arr.insert(.layerMaxXMinYCorner)
                    arr.insert(.layerMinXMaxYCorner)
                    arr.insert(.layerMaxXMaxYCorner)
                default: break
                }
            }
            self.layer.maskedCorners = arr
        } else {
            self.roundCornersBezierPath(corners: corners, radius: radius)
        }
    }
    
    private func roundCornersBezierPath(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
