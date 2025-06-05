//
//  SelectRoomsAndGuestsVC.swift
//  HotelBooking
//
//  Created by toqsoft on 05/06/25.
//

import UIKit

class SelectRoomsAndGuestsVC: UIViewController {

    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var readMoreButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var minusRoomButton: UIButton!
    @IBOutlet weak var roomCountLabel: UILabel!
    @IBOutlet weak var plusRoomButton: UIButton!
    @IBOutlet weak var adultsMinusButton: UIButton!
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var adultsPlusButton: UIButton!
    @IBOutlet weak var childrenMinusButton: UIButton!
    @IBOutlet weak var childrenCountlabel: UILabel!
    @IBOutlet weak var childrenPlusButton: UIButton!
    @IBOutlet weak var petsSwitch: UISwitch!
    @IBOutlet weak var childrensListTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var ageOfChildLabel: UILabel!
    @IBOutlet weak var childDescriptionLabel: UILabel!
    
    var roomCount = 1
    var adultsCount = 1
    var childrenCount = 0
    
    var onApply: ((Int, Int, Int) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func readMoreButtonTapped(_ sender: Any) {}
    
    @IBAction func minusRoomButtonAction(_ sender: Any) {
        if roomCount > 1 {
            roomCount -= 1
            updateCountLabels()
        }
    }
    
    @IBAction func plusRoomButtonAction(_ sender: Any) {
        roomCount += 1
        updateCountLabels()
    }
    
    @IBAction func adultsMinusButtonAction(_ sender: Any) {
        if adultsCount > 1 {
            adultsCount -= 1
            updateCountLabels()
        }
    }
    
    @IBAction func adultsPlusButtonAction(_ sender: Any) {
        adultsCount += 1
        updateCountLabels()
    }
    
    @IBAction func childrenMinusButtonAction(_ sender: Any) {
        if childrenCount > 0 {
            childrenCount -= 1
            updateCountLabels()

            childrensListTableView.reloadData()

            if childrenCount == 0 {
                ageOfChildLabel.isHidden = true
                childDescriptionLabel.isHidden = true
                dismissButton.isHidden = true
                childrensListTableView.isHidden = true

                collapseSheetToMedium()
            }
        }
    }
    
    @IBAction func childrenPlusButtonAction(_ sender: Any) {
        childrenCount += 1
        updateCountLabels()

        ageOfChildLabel.isHidden = false
        childDescriptionLabel.isHidden = false
        dismissButton.isHidden = false
        childrensListTableView.isHidden = false

        childrensListTableView.reloadData()
        expandSheetToFullScreen()
    }
    
    @IBAction func petsSwitchAction(_ sender: Any) {}
    
    @IBAction func applyButtonAction(_ sender: Any) {
        onApply?(roomCount, adultsCount, childrenCount)
        self.dismiss(animated: true)
    }
}

extension SelectRoomsAndGuestsVC : UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenCount
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenAgeTVC") as! ChildrenAgeTVC
        cell.childTitleLabel.text = "Child \(indexPath.row + 1)"
        return cell
    }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 100
   }
}

extension SelectRoomsAndGuestsVC {
    func setUpUI() {
        
        childrensListTableView.register(UINib(nibName: "ChildrenAgeTVC", bundle: nil), forCellReuseIdentifier: "ChildrenAgeTVC")
        
        bottomView.addTopShadow()
        ageOfChildLabel.isHidden = true
        childDescriptionLabel.isHidden = true
        dismissButton.isHidden = true
        childrensListTableView.isHidden = true
        
        let fullText = "Assistance animals aren't considerd pets. Read more about travelling with assistance animals."
        let blackText = "Assistance animals aren't considerd pets. "
        let linkText = "Read more about travelling with assistance animals."
        
        let attributedString = NSMutableAttributedString(
            string: fullText,
            attributes: [
                .font: UIFont.systemFont(ofSize: 15),
                .foregroundColor: UIColor.systemBlue
            ]
        )
        
        attributedString.addAttribute(
            .foregroundColor,
            value: UIColor.black,
            range: (fullText as NSString).range(of: blackText)
        )
        
        readMoreButton.setAttributedTitle(attributedString, for: .normal)
        readMoreButton.titleLabel?.numberOfLines = 0
        readMoreButton.titleLabel?.lineBreakMode = .byWordWrapping
        readMoreButton.titleLabel?.textAlignment = .left
        readMoreButton.contentHorizontalAlignment = .left
        
        updateCountLabels()
    }
    
    func updateCountLabels() {
        roomCountLabel.text = "\(roomCount)"
        adultsCountLabel.text = "\(adultsCount)"
        childrenCountlabel.text = "\(childrenCount)"
        
        minusRoomButton.isEnabled = roomCount > 1
        adultsMinusButton.isEnabled = adultsCount > 1
        childrenMinusButton.isEnabled = childrenCount > 0
    }
    
    func expandSheetToFullScreen() {
        if let sheet = self.sheetPresentationController {
            if #available(iOS 16.0, *) {
                if !sheet.detents.contains(where: { $0.identifier == .large }) {
                    sheet.detents.append(.large())
                }
                sheet.animateChanges {
                    sheet.selectedDetentIdentifier = .large
                }
            }
        }
    }
    
    func collapseSheetToMedium() {
        if let sheet = self.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.animateChanges {
                    sheet.detents = [
                        .custom(identifier: .medium, resolver: { context in
                            return context.maximumDetentValue * 0.6
                        })
                    ]
                    sheet.selectedDetentIdentifier = .medium
                }
            }
        }
    }
}

