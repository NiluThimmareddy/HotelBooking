//
//  SignupViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import UIKit

class SignupViewController: UIViewController {

    let viewmodel = SignupViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
}
