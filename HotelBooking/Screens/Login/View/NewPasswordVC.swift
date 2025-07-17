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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmPasswordButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "PasswordResetSuccessfulVC") as! PasswordResetSuccessfulVC
        storyboard.modalPresentationStyle = .popover
        present(storyboard, animated: true)
    }
    
}
