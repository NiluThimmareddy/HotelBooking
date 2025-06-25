//
//  ChildrenGuestTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 09/06/25.
//

import UIKit

class ChildrenGuestTVC: UITableViewCell {

    @IBOutlet weak var selectAgeButton: UIButton!
    @IBOutlet weak var childCountLbl: UILabel!
    
    var onSelectAgeTapped: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectAgeButton.layer.cornerRadius = 10
        selectAgeButton.layer.borderWidth = 2
        selectAgeButton.layer.borderColor = UIColor.lightGray.cgColor
        applyFontText()
    }
    func applyFontText(){
        let applyBt = NSAttributedString(
            string: "Select",
            attributes: [.font: UIFont.poppinsBold(14), .foregroundColor: UIColor.gray]
        )
        selectAgeButton.setAttributedTitle(applyBt, for: .normal)
        childCountLbl.font = .poppinsBold(14)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    @IBAction func selectAgeButton(_ sender: Any) {
        onSelectAgeTapped?()
    }
}
