//
//  PasswordResetSuccessfulVC.swift
//  HotelBooking
//
//  Created by toqsoft on 16/07/25.
//

import UIKit

class PasswordResetSuccessfulVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    @IBAction func goToSigninPageButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
}
