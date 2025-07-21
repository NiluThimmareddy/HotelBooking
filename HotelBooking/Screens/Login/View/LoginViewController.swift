//
//  LoginViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var forgotPassword: UIButton!
    @IBOutlet weak var signInbutton: UIButton!
    @IBOutlet weak var googleButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var appleButton: UIButton!
    @IBOutlet weak var registerNowButton: UIButton!
    @IBOutlet weak var eyeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.applyGradient()
        googleButton.applyGradient()
        facebookButton.applyGradient()
        appleButton.applyGradient()
        [backView].forEach { topCorner in
            topCorner.clipsToBounds = true
            topCorner.layer.cornerRadius = 30
            topCorner.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }
    
    @IBAction func eyeButtonAction(_ sender: Any) {
        passwordTF.isSecureTextEntry.toggle()
        let eyeImageName = passwordTF.isSecureTextEntry ? "eye.slash.fill" : "eye"
        let config = UIImage.SymbolConfiguration(pointSize: 14, weight: .regular)
        let image = UIImage(systemName: eyeImageName, withConfiguration: config)
        eyeButton.setImage(image, for: .normal)
    }
    
    @IBAction func forgotPassword(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "ForgotPasswordVC") as! ForgotPasswordVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navController = storyboard.instantiateViewController(withIdentifier: "NavigationViewController")
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let sceneDelegate = windowScene.delegate as? SceneDelegate {
            sceneDelegate.window?.rootViewController = navController
            sceneDelegate.window?.makeKeyAndVisible()
        }
    }
    
    @IBAction func googleButtonAction(_ sender: Any) {
    }
    
    @IBAction func facebookButtonAction(_ sender: Any) {
    }
    
    @IBAction func appleButtonAction(_ sender: Any) {
    }
    
    @IBAction func registerNowButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Signup", bundle: nil).instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        storyboard.modalPresentationStyle = .fullScreen
        self.present(storyboard, animated: true)
    }
}
