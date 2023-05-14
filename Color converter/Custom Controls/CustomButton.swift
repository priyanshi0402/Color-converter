//
//  CustomButton.swift
//  3D Storage
//
//
//  Created by Avadh on 09/05/22.
//

import UIKit

// MARK: Custom Button Class
class CustomButton: UIButton {

    // MARK: Set Button cornerRadius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    // MARK: Set Button borderWidth
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    // MARK: Set Button borderColor
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    @IBInspectable var highlightColor: UIColor? {
        didSet {
            let image = imageFromColor(colour: highlightColor!)
            let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            let stretchable = image.resizableImage(withCapInsets: insets, resizingMode: .tile)
            self.setBackgroundImage(stretchable, for: .highlighted)
        }
    }

    func imageFromColor(colour: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(colour.cgColor)
        context!.fill(rect)
        context?.addArc(center: CGPoint.zero, radius: 10, startAngle: 0, endAngle: 360, clockwise: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }

    // MARK: Set Button tag
    var tag1 = 0
    var tag2 = ""
    var tag3 = 0
}

class CustomBarButtonItem: UIBarButtonItem {
    var indexTag = 0
    var tag1 = 0
}
