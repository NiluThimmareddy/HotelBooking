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
    func applyCardStyle(cornerRadius: CGFloat = 15,
                        shadowOffset: CGSize = CGSize(width: 0, height: 1),
                        shadowRadius: CGFloat = 2,
                        shadowOpacity: Float = 0.8,
                        shadowColor: UIColor = .black) {

        self.layer.cornerRadius = cornerRadius
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.masksToBounds = false
        self.layer.shadowPath = nil
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
    

}

  
