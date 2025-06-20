//
//  BookingConformationVC.swift
//  HotelBooking
//
//  Created by toqsoft on 19/06/25.
//

import UIKit

class BookingConformationVC: UIViewController {

    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var confirmationEmailLabel: UILabel!
    @IBOutlet weak var gotoHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingDetailsView.applyCardStyle()
        
    }

    @IBAction func gotoHomeButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        self.navigationController?.setViewControllers([homeVC], animated: true)
    }
}
