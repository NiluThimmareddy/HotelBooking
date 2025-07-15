//
//  Extension.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import Foundation
import UIKit
import ObjectiveC

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
    func backViewBlackShadow(backgroundColor: UIColor = .white,
                             shadowColor: UIColor = .black,
                             shadowOpacity: Float = 0.5,
                             shadowOffset: CGSize = CGSize(width: 0, height: 1),
                             shadowRadius: CGFloat = 3) {
            self.backgroundColor = backgroundColor
            self.layer.masksToBounds = false
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOpacity = shadowOpacity
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowRadius = shadowRadius
        }
    func addTopShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: -3)
        self.layer.shadowRadius = 4
    }
    
    func addBottomShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = 0.2
        self.layer.shadowOffset = CGSize(width: 0, height: 3)
        self.layer.shadowRadius = 4

        let shadowRect = CGRect(x: 0, y: self.bounds.height - 4, width: self.bounds.width, height: 4)
        self.layer.shadowPath = UIBezierPath(rect: shadowRect).cgPath
    }
    
    func applyVerticalGradient(fromColor: UIColor, toColor: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [fromColor.cgColor, toColor.cgColor]
        gradientLayer.locations = [0.0, 0.35]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.frame = self.bounds
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func applyGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(red: 48.0/255, green: 105.0/255, blue: 178.0/255, alpha: 1.0).cgColor,
            UIColor(red: 0.0/255, green: 59.0/255, blue: 149.0/255, alpha: 1.0).cgColor
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradientLayer.frame = self.bounds
        self.layer.sublayers?.removeAll(where: { $0 is CAGradientLayer })
        self.layer.insertSublayer(gradientLayer, at: 0)
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
    func allSubviewsRecursive() -> [UIView] {
            return subviews + subviews.flatMap { $0.allSubviewsRecursive() }
        }

 
        func startPulseShimmerr() {
            let pulse = CABasicAnimation(keyPath: "opacity")
            pulse.duration = 0.8
            pulse.fromValue = 0.5
            pulse.toValue = 1
            pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            pulse.autoreverses = true
            pulse.repeatCount = .infinity
            self.layer.add(pulse, forKey: "pulseShimmer")
        }

        func stopPulseShimmer() {
            self.layer.removeAnimation(forKey: "pulseShimmer")
        }
    
    func startPulseShimmer() {
           stopShimmering()

           let lightGray = UIColor.systemGray4.cgColor
           let white = UIColor.white.withAlphaComponent(0.6).cgColor

           let gradient = CAGradientLayer()
           gradient.colors = [lightGray, white, lightGray]
           gradient.locations = [0, 0.5, 1]
           gradient.startPoint = CGPoint(x: 0, y: 0.5)
           gradient.endPoint = CGPoint(x: 1, y: 0.5)
           gradient.frame = self.bounds
           gradient.name = "pulseShimmerLayer"

           let animation = CABasicAnimation(keyPath: "locations")
           animation.fromValue = [-1, -0.2, 0.2]
           animation.toValue = [0.8, 1.2, 2]
           animation.duration = 0.8 // faster pulse
           animation.repeatCount = .infinity

           gradient.add(animation, forKey: "pulseShimmer")
           self.layer.mask = gradient
       }
       
       func stopShimmering() {
           self.layer.mask = nil
           self.layer.sublayers?.removeAll { $0.name == "pulseShimmerLayer" }
       }
}

extension UIFont {
    static func poppinsMedium(_ size: CGFloat) -> UIFont {
        UIFont(name: "Poppins-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    }

    static func poppinsBold(_ size: CGFloat) -> UIFont {
        UIFont(name: "Poppins-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}

extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        hexSanitized = hexSanitized.replacingOccurrences(of: "#", with: "")
        
        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)
        
        let hasAlpha = hexSanitized.count == 8
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255
        let g = CGFloat((rgb & 0x00FF00) >> 8) / 255
        let b = CGFloat(rgb & 0x0000FF) / 255
        let a = hasAlpha ? CGFloat((rgb & 0xFF000000) >> 24) / 255 : 1
        
        self.init(red: r, green: g, blue: b, alpha: a)
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
    
    func applyFullBlackGradient() {
        let gradient = CAGradientLayer()
        gradient.colors = [
            UIColor.black.withAlphaComponent(0.50).cgColor,
            UIColor.black.withAlphaComponent(0.50).cgColor
        ]
        gradient.locations = [0.0, 1.0]
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

extension UIView {
    func makeAllSubviewsSkeletonable() {
        self.isSkeletonable = true
        for subview in self.subviews {
            subview.makeAllSubviewsSkeletonable()
        }
    }
}

extension UIViewController {
    func hideNavigationBar(animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func showNavigationBar(animated: Bool = true) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}

extension UIViewController {
    func showAlert(title: String = "Error", message: String, buttonTitle: String = "OK") {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: buttonTitle, style: .default))
        self.present(alert, animated: true)
    }
}
extension Date {
    static func todayAndTomorrowFormattedRange() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd MMM" 

        let today = Date()
        let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!

        let todayString = dateFormatter.string(from: today)
        let tomorrowString = dateFormatter.string(from: tomorrow)

        return "\(todayString) - \(tomorrowString)"
    }
}
private var placeholderLabelKey: UInt8 = 0

extension UITextView {
 
    var placeholder: String? {
        get {
            return placeholderLabel?.text
        }
        set {
            if let label = placeholderLabel {
                label.text = newValue
            } else {
                let label = UILabel()
                label.text = newValue
                label.font = self.font
                label.textColor = .lightGray
                label.numberOfLines = 0
                label.translatesAutoresizingMaskIntoConstraints = false
                label.isUserInteractionEnabled = false
                addSubview(label)
                sendSubviewToBack(label)
 
                NSLayoutConstraint.activate([
                    label.topAnchor.constraint(equalTo: self.topAnchor, constant: 8),
                    label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
                    label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
                ])
 
                placeholderLabel = label
 
                NotificationCenter.default.addObserver(self, selector: #selector(textDidChangeInTextView), name: UITextView.textDidChangeNotification, object: self)
            }
 
            placeholderLabel?.isHidden = !(self.text?.isEmpty ?? true)
        }
    }
 
    private var placeholderLabel: UILabel? {
        get {
            return objc_getAssociatedObject(self, &placeholderLabelKey) as? UILabel
        }
        set {
            objc_setAssociatedObject(self, &placeholderLabelKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
 
    @objc private func textDidChangeInTextView() {
        placeholderLabel?.isHidden = !(self.text?.isEmpty ?? true)
    }
}
 
 
extension UIView {
    func pinToEdges(of superview: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: superview.topAnchor),
            leadingAnchor.constraint(equalTo: superview.leadingAnchor),
            trailingAnchor.constraint(equalTo: superview.trailingAnchor),
            bottomAnchor.constraint(equalTo: superview.bottomAnchor)
        ])
    }
}
