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

        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    }

    @IBAction func goToSigninPageButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
}
