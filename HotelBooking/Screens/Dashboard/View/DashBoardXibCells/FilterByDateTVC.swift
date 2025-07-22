//
//  FilterByDateTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 04/06/25.
//

import UIKit

class FilterByDateTVC: UITableViewCell {

    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var titleLbl: UILabel!
    
    private var isChecked = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCheckboxState()
        titleLbl.font = .poppinsMedium(12)
    }
    
    private func setCheckboxState() {
        let imageName = isChecked ? "checkmark.square" : "square"
        checkBoxButton.setImage(UIImage(systemName: imageName), for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func checkBoxButton(_ sender: Any) {
        isChecked.toggle()
        setCheckboxState()
    }
}
