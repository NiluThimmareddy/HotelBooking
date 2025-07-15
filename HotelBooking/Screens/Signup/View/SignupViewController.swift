//
//  SignupViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import UIKit

class SignupViewController : UIViewController {

    let viewmodel = SignupViewModel()
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var emailIdTF: UITextField!
    @IBOutlet weak var mobileNoTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var conformPasswordTF: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButtonAction: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        topView.applyGradient()
        [backView].forEach { topCorner in
            topCorner.clipsToBounds = true
            topCorner.layer.cornerRadius = 30
            topCorner.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
    }

    func bindViewModel(){
        viewmodel.isLoading = { [weak self] isLoading in
            if isLoading {
                self?.showActivityIndicator()
            }else{
                self?.hideActivityIndicator()
            }
            
        }
    }
    
    @IBAction func signInButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "NavigationViewController")
        controller.modalPresentationStyle = .fullScreen
        self.present(controller, animated: true)
    }
    
}
