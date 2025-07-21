//
//  NewPasswordVC.swift
//  HotelBooking
//
//  Created by toqsoft on 15/07/25.
//

import UIKit

class NewPasswordVC: UIViewController {
    
    @IBOutlet weak var enterPasswordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var passwordEyeButton: UIButton!
    @IBOutlet weak var confirmPasswordEyeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func passwordEyeButtonAction(_ sender: Any) {
        enterPasswordTF.isSecureTextEntry.toggle()
        let eyeImageName = enterPasswordTF.isSecureTextEntry ? "eye.slash.fill" : "eye"
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: eyeImageName, withConfiguration: config)
        passwordEyeButton.setImage(image, for: .normal)
    }
    
    @IBAction func confirmPasswordEyeButtonAction(_ sender: Any) {
        confirmPasswordTF.isSecureTextEntry.toggle()
        let eyeImageName = confirmPasswordTF.isSecureTextEntry ? "eye.slash.fill" : "eye"
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: eyeImageName, withConfiguration: config)
        confirmPasswordEyeButton.setImage(image, for: .normal)
    }
    
    @IBAction func confirmPasswordButtonAction(_ sender: Any) {
        let successVC = storyboard?.instantiateViewController(withIdentifier: "PasswordResetSuccessfulVC") as! PasswordResetSuccessfulVC
        successVC.modalPresentationStyle = .overCurrentContext
        successVC.modalTransitionStyle = .crossDissolve
        self.present(successVC, animated: true)
    }
    
}
