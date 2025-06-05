//
//  ChildrenAgeTVC.swift
//  HotelBooking
//
//  Created by toqsoft on 05/06/25.
//

import UIKit

class ChildrenAgeTVC : UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var childTitleLabel: UILabel!
    @IBOutlet weak var selectAgeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureAgeMenu()
    }
    
    func configureAgeMenu() {
        var ageActions: [UIAction] = []
        
        for age in 1...17 {
            let action = UIAction(title: "\(age) years") { [weak self] _ in
                self?.selectAgeButton.setTitle("\(age) years", for: .normal)
            }
            ageActions.append(action)
        }
        
        let ageMenu = UIMenu(title: "Select Age", options: .displayInline, children: ageActions)
        selectAgeButton.menu = ageMenu
        selectAgeButton.showsMenuAsPrimaryAction = true
    }
    
}
