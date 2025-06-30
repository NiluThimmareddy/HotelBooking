//
//  BookingConformationVC.swift
//  HotelBooking
//
//  Created by toqsoft on 19/06/25.
//

import UIKit

class BookingConformationVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var bookingDetailsView: UIView!
    @IBOutlet weak var confirmationEmailLabel: UILabel!
    @IBOutlet weak var gotoHomeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bookingDetailsView.applyCardStyle()
        
        hotelImageView.clipsToBounds = true
        hotelImageView.layer.cornerRadius = 100
        hotelImageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated: false)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar(animated: false)
    }

    @IBAction func gotoHomeButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let homeVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
        self.showNavigationBar(animated: false)
        self.navigationController?.setViewControllers([homeVC], animated: true)
    }
}
