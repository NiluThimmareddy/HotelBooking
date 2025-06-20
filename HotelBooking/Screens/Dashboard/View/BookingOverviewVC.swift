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
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var guestView: UIView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var addGuestButton: UIButton!
    @IBOutlet weak var guestsListTableview: UITableView!
    @IBOutlet weak var selectGuestButton: UIButton!
    @IBOutlet weak var addGuestView: UIView!
    @IBOutlet weak var dismissAddGuestPage: UIButton!
    @IBOutlet weak var firstNameTF: UITextField!
    @IBOutlet weak var lastNameTF: UITextField!
    @IBOutlet weak var confirmButton: UIButton!
    @IBOutlet weak var guestInfoView: UIView!
    @IBOutlet weak var closeInfoButton: UIButton!
    @IBOutlet weak var updateFirstName: UITextField!
    @IBOutlet weak var updateLastName: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    
    
    var selectedIndex: Int?
    let selectedColor = UIColor(hex: "#003B95")
    
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
    
    var guestsList = ["Rohit Sharma","Virat Kohli","Jasprit Bumrah"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
    }

    @IBAction func selectGuestButtonAction(_ sender: Any) {
        guestView.isHidden = false
    }
    
    @IBAction func priceSummaryButtonAction(_ sender: Any) {
        pricePopView.isHidden = false
    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        pricePopView.isHidden = true
    }
    
    @IBAction func countryCodeButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func bookNowButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BookingConformationVC") as! BookingConformationVC
        controller.navigationItem.title = "Booking Confirmed"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        guestView.isHidden = true
    }
    
    @IBAction func addGuestButtonAction(_ sender: Any) {
        addGuestView.isHidden = false
    }
    
    @IBAction func dismissAddGuestPageButtonAction(_ sender: Any) {
        addGuestView.isHidden = true
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
    }
    
    @IBAction func closeInfoButtonAction(_ sender: Any) {
        guestInfoView.isHidden = true
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
    }
    
    
}

extension BookingOverviewVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return guestsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestListTVC") as! GuestListTVC
        cell.guestNameLabel.text = guestsList[indexPath.row]
        
        let isSelected = selectedIndex == indexPath.row
        let imageName = isSelected ? "record.circle.fill" : "circle"
        cell.selectButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.selectButton.tintColor = isSelected ? selectedColor : .systemGray
        
        cell.delegate = self
        print("Configured cell for row \(indexPath.row)")
        return cell
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

        guestsListTableview.register(UINib(nibName: "GuestListTVC", bundle: nil), forCellReuseIdentifier: "GuestListTVC")
        [guestView,addGuestView,guestInfoView].forEach { view in
            view?.addTopShadow()
            view?.isHidden = true
        }
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

extension BookingOverviewVC: GuestListCellDelegate {
    func didTapEditButton(in cell: GuestListTVC) {
        if let indexPath = guestsListTableview.indexPath(for: cell) {
            let fullName = guestsList[indexPath.row]
            let nameComponents = fullName.components(separatedBy: " ")
            
            if nameComponents.count >= 2 {
                updateFirstName.text = nameComponents[0]
                updateLastName.text = nameComponents.dropFirst().joined(separator: " ")
            } else {
                updateFirstName.text = fullName
                updateLastName.text = ""
            }
        }
        guestInfoView.isHidden = false
    }
    
    func didTapSelectButton(in cell: GuestListTVC) {
        guard let indexPath = guestsListTableview.indexPath(for: cell) else { return }

        selectedIndex = indexPath.row

        let fullName = guestsList[indexPath.row]
        let nameComponents = fullName.components(separatedBy: " ")

        if nameComponents.count >= 2 {
            firstNameTextField.text = nameComponents[0]
            lastNameTextField.text = nameComponents.dropFirst().joined(separator: " ")
        } else {
            firstNameTextField.text = fullName
            lastNameTextField.text = ""
        }

        guestsListTableview.reloadData()

        addGuestView.isHidden = true
        guestView.isHidden = true
    }
}
