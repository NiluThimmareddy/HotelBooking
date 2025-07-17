//
//  ForgotPasswordVC.swift
//  HotelBooking
//
//  Created by toqsoft on 15/07/25.
//

import UIKit

class ForgotPasswordVC: UIViewController {

    @IBOutlet weak var confirmMailButton: UIButton!
    @IBOutlet weak var emailIdTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmMailButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "VerificationCodeVC") as! VerificationCodeVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
}
