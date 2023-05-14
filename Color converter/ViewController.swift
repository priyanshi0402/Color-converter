//
//  ViewController.swift
//  Color converter
//
//  Created by SARVADHI on 30/04/23.
//

import UIKit
import Toast_Swift
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var menuViee: UIView!
    @IBOutlet weak var previewView: CustomView!
    @IBOutlet weak var txtB: CustomTextField!
    @IBOutlet weak var txtG: CustomTextField!
    @IBOutlet weak var txtR: CustomTextField!
    @IBOutlet weak var txtBright: CustomTextField!
    @IBOutlet weak var txtSat: CustomTextField!
    @IBOutlet weak var txtHue: CustomTextField!
    @IBOutlet weak var lblHex: UILabel!
    @IBOutlet weak var lblHsb: UILabel!
    @IBOutlet weak var lblRGB: UILabel!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var hsbView: CustomView!
    @IBOutlet weak var rgbView: CustomView!
    @IBOutlet weak var hexView: CustomView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var txtHex: UITextField!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.bottomView.roundCorners(radius: 30, corners: [.topLeft, .topRight])
        self.txtHex.clearButtonMode = .whileEditing
        self.menuViee.roundCorners(radius: 10, corners: [.topLeft, .bottomLeft])
        menuViee.isHidden = true
        
    }
    
    func ShareMyApp() {
        let activityItems : NSArray = ["itms-apps://itunes.apple.com/us/app/apple-store/id6447046704?mt=8"]
        let activityVC : UIActivityViewController = UIActivityViewController(activityItems: activityItems as! [Any], applicationActivities: nil)
        present(activityVC, animated: true, completion: nil)
    }
    
    func rateApp() {
        if #available(iOS 10.3, *) {
            SKStoreReviewController.requestReview()
        } else if let url = URL(string: "itms-apps://itunes.apple.com/app/" + "6447046704") {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }


    @IBAction func shareAppAction(_ sender: Any) {
        self.ShareMyApp()
    }
    
    @IBAction func feedBackAction(_ sender: Any) {
        self.rateApp()
    }
    
    @IBAction func aboutUs(_ sender: Any) {
        self.showAlert(vc: self, title: "Welcome to Color converter", message: "Hello User, \n Here we help you easily transform colors between different formats. Our mission is to make color conversion a seamless and effortless experience for designers, artists, and anyone who works with color. With our intuitive interface and advanced algorithms, you can quickly and accurately convert colors in RGB to HEX and more.")
    }
    
    @IBAction func actionMenu(_ sender: Any) {
        menuViee.isHidden = !menuViee.isHidden
    }
    
    @IBAction func actionCopy(_ sender: UIButton) {
        var string = ""
        if sender.tag == 101 {
            string = lblRGB.text ?? ""
        } else if sender.tag == 102 {
            string = lblHex.text ?? ""
        } else if sender.tag == 103 {
            string = lblHsb.text ?? ""
        }
        
        UIPasteboard.general.string = string
        self.view.makeToast("Copied to clipboard!", duration: 1.0, position: .center)
        
    }
    
    @IBAction func actionConvertBtn(_ sender: Any) {
        switch self.segmentControl.selectedSegmentIndex {
        case 0:
            self.convertHex()
        case 1:
            self.convertRGB()
        case 2:
            self.convertHSB()
        default: break
            
        }
    }
    
    @IBAction func actionSegment(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            self.rgbView.isHidden = true
            self.hsbView.isHidden = true
            self.hexView.isHidden = false
        case 1:
            self.hexView.isHidden = true
            self.hsbView.isHidden = true
            self.rgbView.isHidden = false
        case 2:
            self.hexView.isHidden = true
            self.rgbView.isHidden = true
            self.hsbView.isHidden = false
        default: break
            
        }
    }
    
    func convertHex() {
        let hex = self.txtHex.text ?? ""
        if hex.isEmpty || hex.count > 7 {
            self.showAlert(vc: self, title: "Alert!!", message: "Please enter valid Hex")
        } else {
            let color = UIColor(hexString: hex)
            let ciColor = CIColor(color: color)
            print(ciColor)
            let r = String(format: "%.2f", ciColor.red)
            let g = String(format: "%.2f", ciColor.green)
            let b = String(format: "%.2f", ciColor.blue)
            
            
            self.lblHsb.text = "UIColor(red:\(r), green: \(g), blue: \(b), alpha: 1.0) "
            self.lblHex.text = color.hexStringFromColor()
            self.previewView.backgroundColor = color
            
            let (r1, g1, b1) = hexToRgb(hex: hex)
            self.lblRGB.text = "rgb(" + r1 + ", " + g1 + ", " + b1 + ")"
            self.txtR.text = r1
            self.txtG.text = g1
            self.txtB.text = b1
            
        }
    }
    
    func convertRGB() {
        let textR = self.txtR.text ?? ""
        let textG = self.txtG.text ?? ""
        let textB = self.txtB.text ?? ""
        if textR.isEmpty && textG.isEmpty && textB.isEmpty {
            self.showAlert(vc: self, title: "Alert!!", message: "Please enter valid RGB")
        } else {
            let color = UIColor(red: textR.toFloat/255, green: textG.toFloat/255, blue: textB.toFloat/255, alpha: 1.0)
            self.lblRGB.text = "rgb(" + textR + ", " + textG + ", " + textB + ")"
            let r = String(format: "%.2f", textR.toFloat/255)
            let g = String(format: "%.2f", textG.toFloat/255)
            let b = String(format: "%.2f", textB.toFloat/255)
            self.lblHsb.text = "UIColor(red:\(r), green: \(g), blue: \(b), alpha: 1.0) "
            self.lblHex.text = color.hexStringFromColor()
            var hex = color.hexStringFromColor()
            hex.removeAll(where: {$0 == "#"})
            self.txtHex.text = hex
            print(color.description)
            self.previewView.backgroundColor = color
        }
    }
    
    func convertHSB() {
        
    }
    
    func showAlert(vc: UIViewController, title: String, message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            vc.present(alert, animated: true, completion: nil)
        }
    }
    
    func hexToRgb(hex: String) -> (String, String, String) {
        if hex != "" {
            var hex = hex
            if hex.localizedCaseInsensitiveContains("#") {
                hex.removeAll(where: {$0 == "#"})
            }
            if hex.count == 6 {
                let bigint = Int(hex, radix: 16)
                if bigint != nil {
                    let r = (bigint! >> 16) & 255
                    let g = (bigint! >> 8) & 255
                    let b = bigint! & 255
//                    let rgbResult = "rgb(" + String(r) + ", " + String(g) + ", " + String(b) + ")"
                    return (String(r), String(g), String(b))
                }
            }
        }
        return (String(255), String(255), String(255))
    }
    
    
}

extension String {
    var toFloat: CGFloat {
        if let num = NumberFormatter().number(from: self) {
            return CGFloat(num.floatValue).rounded()
        } else {
            return CGFloat(0).rounded()
        }
    }
}

extension UIColor {
    func hexStringFromColor() -> String {
        let components = self.cgColor.components
        let r: CGFloat = components?[0] ?? 0.0
        let g: CGFloat = components?[1] ?? 0.0
        let b: CGFloat = components?[2] ?? 0.0
        
        let hexString = String.init(format: "#%02lX%02lX%02lX", lroundf(Float(r * 255)), lroundf(Float(g * 255)), lroundf(Float(b * 255)))
        return hexString
    }
    
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

extension String {
    public func validHex() -> Bool {
        let phoneNumberRegex = "/^#[0-9a-f]{3}(?:[0-9a-f]{3})?$/i"
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validatePhone = NSPredicate(format: "SELF MATCHES %@", phoneNumberRegex)
        let isValidPhone = validatePhone.evaluate(with: trimmedString)
        return isValidPhone
    }
}
