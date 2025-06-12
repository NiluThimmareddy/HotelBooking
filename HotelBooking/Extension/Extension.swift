//
//  Extension.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import Foundation
import UIKit

extension UIViewController{
    enum AlertType{
        case success
        case error
        case info
    }
    
    func showAlert(
        title:String,
        message:String,
        type: AlertType = .info,
        OkButtonTitle: String = "OK",
        cancelButtonTitle:String? = nil,
        onOK : (()-> Void)? = nil,
        onCancel: (()-> Void)? = nil
    ){
        var finalTitle = title
        switch type {
        case .success : finalTitle =  "✅ " + title
        case .error : finalTitle = "❌ " + title
        case .info: finalTitle = "ℹ️ " + title
        }
        
        let alert = UIAlertController(title: finalTitle, message: message, preferredStyle: .alert)
        
        //Ok button Action
        alert.addAction(UIAlertAction(title: OkButtonTitle  , style: .default) { _ in
            onOK?()
        })
        
        
        //Optional Delete Button Action
        
        if let cancel = cancelButtonTitle {
            alert.addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
                onCancel?()
            })
        }
        self.present(alert, animated: true, completion: nil)
    }
}


/*
 self?.showAlert(title: "Error", message: "Something went wrong", type: .error)
 self?.showAlert(title: "Success", message: "User data loaded successfully", type: .success)
 self?.showAlert(title: "Info", message: "Please fill all required fields", type: .info)
 
 
 self.showAlert(
 title: "Delete Data?",
 message: "Are you sure you want to delete this?",
 type: .confirm,
 okTitle: "Yes",
 cancelTitle: "Cancel",
 onOK: {
 // Perform deletion here
 print("Data deleted")
 },
 onCancel: {
 print("Cancelled")
 }
 )
 */

extension UIViewController {
    
    private static var spinnerTag: Int { return 999_999 }
    
    func showActivityIndicator() {
        if self.view.viewWithTag(Self.spinnerTag) != nil { return }
        
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.center = self.view.center
        spinner.hidesWhenStopped = true
        spinner.color = .gray
        spinner.tag = Self.spinnerTag
        
        spinner.startAnimating()
        self.view.addSubview(spinner)
        self.view.isUserInteractionEnabled = false
    }
    
    func hideActivityIndicator() {
        if let spinner = self.view.viewWithTag(Self.spinnerTag) as? UIActivityIndicatorView {
            spinner.stopAnimating()
            spinner.removeFromSuperview()
            self.view.isUserInteractionEnabled = true
        }
    }
}

extension UIView {
    
    @IBInspectable var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    
    @IBInspectable var borderColor: UIColor {
        get { return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor) }
        set { layer.borderColor = newValue.cgColor }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    func applyCardStyle(shadowOffset: CGSize = CGSize(width: 0, height: 1),
                        shadowRadius: CGFloat = 2,
                        shadowOpacity: Float = 0.8,
                        shadowColor: UIColor = .black) {
        
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowPath = nil
    }
    func BackViewShadowAppyManually(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
    func BackViewShadow(){
        self.layer.shadowOpacity = 0.0
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 0
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.layer.shadowRadius = 4
        self.layer.masksToBounds = false
    }
    
    func addTopShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shadowRadius = 4
    }
    
    func setHighlightedText(for label: UILabel, fullText: String, highlightText: String, normalFont: UIFont = .systemFont(ofSize: 14), highlightFont: UIFont = .boldSystemFont(ofSize: 18), normalColor: UIColor = .darkGray, highlightColor: UIColor = .black) {
        let attributedString = NSMutableAttributedString(string: fullText)
        
        attributedString.addAttributes([
            .font: normalFont,
            .foregroundColor: normalColor
        ], range: NSRange(location: 0, length: attributedString.length))
        
        if let range = fullText.range(of: highlightText) {
            let nsRange = NSRange(range, in: fullText)
            attributedString.addAttributes([
                .font: highlightFont,
                .foregroundColor: highlightColor
            ], range: nsRange)
        }
        
        label.attributedText = attributedString
    }

}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hexSanitized.hasPrefix("#") {
            hexSanitized.remove(at: hexSanitized.startIndex)
        }
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0
        
        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }

}

extension UIImageView {
    func applyStrongLeftGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.85).cgColor,
            UIColor.black.withAlphaComponent(0.55).cgColor,
            UIColor.clear.cgColor
        ]
        gradient.locations = [0.0, 0.35, 1.0]
        gradient.startPoint = CGPoint(x: 0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1, y: 0.5)
        gradient.frame = self.bounds
        gradient.cornerRadius = self.layer.cornerRadius
        gradient.name = "blackOverlay"

        self.layer.sublayers?.removeAll(where: { $0.name == "blackOverlay" })
        self.layer.addSublayer(gradient)
    }
}

extension Array {
    subscript(safe index: Int) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}


extension UIView {
    func addBorder(edge: UIRectEdge, color: UIColor, thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch edge {
        case .top:
            border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom:
            border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        case .left:
            border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right:
            border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        default:
            break
        }
        
        layer.addSublayer(border)
    }
}
