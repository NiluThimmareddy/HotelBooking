//
//  BookingOverviewVC.swift
//  HotelBooking
//
//  Created by toqsoft on 13/06/25.
//

import UIKit

class BookingOverviewVC: UIViewController {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var checkView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var contactView: UIView!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var bookingCashView: UIView!
    @IBOutlet weak var pricePopView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var priceSummaryButton: UIButton!
    
    let countryCodeList: [(name: String, code: String, flag: String)] = [
        ("India", "+91", "🇮🇳"),
        ("USA", "+1", "🇺🇸"),
        ("UK", "+44", "🇬🇧"),
        ("Canada", "+1", "🇨🇦"),
        ("Australia", "+61", "🇦🇺"),
        ("Germany", "+49", "🇩🇪"),
        ("France", "+33", "🇫🇷"),
        ("Japan", "+81", "🇯🇵"),
        ("South Korea", "+82", "🇰🇷"),
        ("UAE", "+971", "🇦🇪")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }

    @IBAction func priceSummaryButtonAction(_ sender: Any) {
        pricePopView.isHidden = false
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        pricePopView.isHidden = true
    }
    
    @IBAction func countryCodeButtonAction(_ sender: UIButton) {
       
    }
    
    
}

extension BookingOverviewVC {
    func setUpUI() {
        [topView,checkView,contactView,bookingCashView].forEach { shadow in
            shadow?.applyCardStyle()
        }
        bottomView.addTopShadow()
        
        pricePopView.isHidden = true
        pricePopView.layer.cornerRadius = 16
        pricePopView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        pricePopView.layer.masksToBounds = true
        pricePopView.addTopShadow()
        configureCountryCodeMenu()
    }
    
    func configureCountryCodeMenu() {
        var menuItems: [UIAction] = []

        for country in countryCodeList {
            let action = UIAction(title: "\(country.flag) \(country.name) \(country.code)", handler: { [weak self] _ in
                self?.countryCodeButton.setTitle(country.code, for: .normal)
            })
            menuItems.append(action)
        }

        let menu = UIMenu(title: "Select Country Code", children: menuItems)
        countryCodeButton.menu = menu
        countryCodeButton.showsMenuAsPrimaryAction = true
    }
}
