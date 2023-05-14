//
//  CustomTextField.swift
//  3D Storage
//
//
//  Created by PRIYANSHI on 09/05/22.
//

import UIKit

private var maxLengthDictionary = [UITextField: Int]()

// MARK: Custom TextField Class
// @IBDesignable
class CustomTextField: UITextField {

    // MARK: Set View In UITextField
    var topBorder: UIView?
    var bottomBorder: UIView?
    var leftBorder: UIView?
    var rightBorder: UIView?
    var leftimageview: UIImageView?
    var rightimageview: UIImageView?

    // MARK: Set TextField cornerRadius
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
            layer.masksToBounds = cornerRadius > 0
        }
    }

    // MARK: Set TextField borderWidth
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }

    // MARK: Set TextField borderColor
    @IBInspectable var borderColor: UIColor? {
        didSet {
            layer.borderColor = borderColor?.cgColor
        }
    }

    // MARK: Set TextField Placeholder Color
    @IBInspectable var placeHolderColor: UIColor = UIColor.lightGray {
        didSet {
            let iVar = class_getInstanceVariable(UITextField.self, "_placeholderLabel")!
            let placeholderLabel = object_getIvar(self, iVar) as? UILabel ?? UILabel()
            placeholderLabel.textColor = placeHolderColor
        }
    }

    // MARK: Set TextField RightSide Image
    @IBInspectable var rightImage: UIImage? {
        didSet {
            if rightImage != nil {
                let width = rightviewWidth < rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightViewMode = UITextField.ViewMode.always
                rightimageview = UIImageView()
                rightimageview!.frame = CGRect(x: self.frame.size.width - width, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
                rightimageview!.image = rightImage
                rightView = rightimageview
                self.rightViewMode = .always
                rightimageview!.contentMode = .center
            }
        }
    }

    // MARK: Set TextField RightSide View Width
    @IBInspectable var rightviewWidth: CGFloat = 0 {
        didSet {
            if rightimageview != nil {
                let width = rightviewWidth < rightImage!.size.width + 10 ? rightviewWidth :  rightImage!.size.width + 10
                rightimageview!.frame = CGRect(x: self.frame.origin.x+5, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
            }
        }
    }

    // MARK: Set TextField LeftSide Image
    @IBInspectable var leftImage: UIImage? {
        didSet {
            if leftImage != nil {
                let width = leftviewWidth < leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftViewMode = UITextField.ViewMode.always
                leftimageview = UIImageView()
                leftimageview!.frame = CGRect(x: self.frame.origin.x+5, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
                leftimageview!.image = leftImage
                leftView = leftimageview
                self.leftViewMode = .always
                leftimageview!.contentMode = .center
            }
        }
    }

    // MARK: Set TextField LeftSide View Width
    @IBInspectable var leftviewWidth: CGFloat = 0 {
        didSet {
            if leftimageview != nil {
                let width = leftviewWidth < leftImage!.size.width + 10 ? leftviewWidth :  leftImage!.size.width + 10
                leftimageview!.frame = CGRect(x: self.frame.origin.x+5, y: self.frame.origin.y+2, width: width, height: CGFloat(self.frame.size.height-4))
            }
        }
    }

    // MARK: Set TextField BottomLine Width
    @IBInspectable var bottomLineWidth: CGFloat = 1 {
        didSet {
            let border: CALayer = CALayer()
            border.borderColor = UIColor.darkGray.cgColor
            self.frame = CGRect(x: 0, y: self.frame.size.height - bottomLineWidth, width: self.frame.size.width, height: self.frame.size.height)
            border.borderWidth = borderWidth
            self.layer.addSublayer(border)
            self.layer.masksToBounds = true
        }
    }

    // MARK: Set TextField BottomLine Color
    @IBInspectable var bottomLineColor: UIColor = UIColor.lightGray {
        didSet {
            let border: CALayer = CALayer()
            border.borderColor = bottomLineColor.cgColor
        }
    }

    // MARK: Set TextField Text Padding
    @IBInspectable var paddingLeft: CGFloat = 0
    @IBInspectable var paddingRight: CGFloat = 0

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: bounds.origin.x + paddingLeft, y: bounds.origin.y, width: bounds.size.width - paddingLeft - paddingRight, height: bounds.size.height)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }

    // MARK: Set TextField Top borderColor and Height
    @IBInspectable var topBorderColor: UIColor = UIColor.clear
    @IBInspectable var topBorderHeight: CGFloat = 0 {
        didSet {
            if topBorder == nil {
                topBorder = UIView()
                topBorder?.backgroundColor = topBorderColor
                topBorder?.frame = CGRect(x: 0, y: 0, width: self.frame.size.width, height: topBorderHeight)
                addSubview(topBorder!)
            }
        }
    }

    // MARK: Set TextField Bottom borderColor and Height
    @IBInspectable var bottomBorderColor: UIColor = UIColor.clear
    @IBInspectable var bottomBorderHeight: CGFloat = 0 {
        didSet {
            if bottomBorder == nil {
                self.layoutSubviews()
                self.layoutIfNeeded()
                self.layer.masksToBounds = true
                bottomBorder = UIView()
                bottomBorder?.backgroundColor=bottomBorderColor
                bottomBorder?.frame = CGRect(x: 0, y: self.frame.size.height - bottomBorderHeight, width: self.frame.size.width, height: bottomBorderHeight)
                addSubview(bottomBorder!)
            }
        }
    }

    // MARK: Set TextField Left borderColor and Height
    @IBInspectable var leftBorderColor: UIColor = UIColor.clear
    @IBInspectable var leftBorderHeight: CGFloat = 0 {
        didSet {
            if leftBorder == nil {
                leftBorder = UIView()
                leftBorder?.backgroundColor=leftBorderColor
                leftBorder?.frame = CGRect(x: 0, y: 0, width: leftBorderHeight, height: self.frame.size.height)
                addSubview(leftBorder!)
            }
        }
    }

    // MARK: Set TextField Right borderColor and Height
    @IBInspectable var rightBorderColor: UIColor = UIColor.clear
    @IBInspectable var rightBorderHeight: CGFloat = 0 {
        didSet {
            if rightBorder == nil {
                rightBorder = UIView()
                rightBorder?.backgroundColor=topBorderColor
                rightBorder?.frame = CGRect(x: self.frame.size.width - rightBorderHeight, y: 0, width: rightBorderHeight, height: self.frame.size.height)
                addSubview(rightBorder!)
            }
        }
    }

    // MARK: Set TextField maxLength
    @IBInspectable var maxLength: Int {
      get {
        // 4
        guard let length = maxLengthDictionary[self] else {
          return Int.max
        }
        return length
      }
      set {
        maxLengthDictionary[self] = newValue
        // 5
        addTarget(
            self,
            action: #selector(limitLength),
            for: .editingChanged
        )
      }
    }

    @objc func limitLength(textField: UITextField) {
      // 6
        let txt = textField.text
        textField.text = "\(txt?.prefix(maxLength) ?? "")"
    }

    // MARK: Set TextField tag
    var tag1 = 0
    var tag2 = ""
    var tagName = ""
}

class RestrictedTextField: CustomTextField {
    private var editActions: [ResponderStandardEditActions: Bool]?
    private var filterEditActions: [ResponderStandardEditActions: Bool]?
    
    func setEditActions(only actions: [ResponderStandardEditActions]) {
        if self.editActions == nil { self.editActions = [:] }
        filterEditActions = nil
        actions.forEach { self.editActions?[$0] = true }
    }
    
    func addToCurrentEditActions(actions: [ResponderStandardEditActions]) {
        if self.filterEditActions == nil { self.filterEditActions = [:] }
        editActions = nil
        actions.forEach { self.filterEditActions?[$0] = true }
    }
    
    private func filterEditActions(actions: [ResponderStandardEditActions], allowed: Bool) {
        if self.filterEditActions == nil { self.filterEditActions = [:] }
        editActions = nil
        actions.forEach { self.filterEditActions?[$0] = allowed }
    }
    
    func filterEditActions(notAllowed: [ResponderStandardEditActions]) {
        filterEditActions(actions: notAllowed, allowed: false)
    }
    
    func resetEditActions() { editActions = nil }
    
    open override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if let actions = editActions {
            for _action in actions where _action.key.selector == action { return _action.value }
            return false
        }
        
        if let actions = filterEditActions {
            for _action in actions where _action.key.selector == action { return _action.value }
        }
        
        return super.canPerformAction(action, withSender: sender)
    }
}

class LocationsTextField: UITextField {

    var tageName: String = ""

    let padding = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.inputAssistantItem.leadingBarButtonGroups = []
        self.inputAssistantItem.trailingBarButtonGroups = []
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    func canPerformAction(action: Selector, withSender sender: AnyObject?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }

}

class TimeTextField: UITextField {

    var tageName: String = ""

    let padding = UIEdgeInsets(top: 0, left: 21, bottom: 0, right: 5)

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.inputAssistantItem.leadingBarButtonGroups = []
        self.inputAssistantItem.trailingBarButtonGroups = []
    }

    override open func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override open func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

}

class CustomPasteTextField: UITextField {
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(UIResponderStandardEditActions.paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

enum ResponderStandardEditActions {
    case cut, copy, paste, select, selectAll, delete
    case makeTextWritingDirectionLeftToRight, makeTextWritingDirectionRightToLeft
    case toggleBoldface, toggleItalics, toggleUnderline
    case increaseSize, decreaseSize
    
    var selector: Selector {
        switch self {
        case .cut:
            return #selector(UIResponderStandardEditActions.cut)
        case .copy:
            return #selector(UIResponderStandardEditActions.copy)
        case .paste:
            return #selector(UIResponderStandardEditActions.paste)
        case .select:
            return #selector(UIResponderStandardEditActions.select)
        case .selectAll:
            return #selector(UIResponderStandardEditActions.selectAll)
        case .delete:
            return #selector(UIResponderStandardEditActions.delete)
        case .makeTextWritingDirectionLeftToRight:
            return #selector(UIResponderStandardEditActions.makeTextWritingDirectionLeftToRight)
        case .makeTextWritingDirectionRightToLeft:
            return #selector(UIResponderStandardEditActions.makeTextWritingDirectionRightToLeft)
        case .toggleBoldface:
            return #selector(UIResponderStandardEditActions.toggleBoldface)
        case .toggleItalics:
            return #selector(UIResponderStandardEditActions.toggleItalics)
        case .toggleUnderline:
            return #selector(UIResponderStandardEditActions.toggleUnderline)
        case .increaseSize:
            return #selector(UIResponderStandardEditActions.increaseSize)
        case .decreaseSize:
            return #selector(UIResponderStandardEditActions.decreaseSize)
        }
    }
}
