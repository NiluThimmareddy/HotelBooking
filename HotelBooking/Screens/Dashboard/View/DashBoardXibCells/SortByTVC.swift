//
//  SortByTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 04/06/25.
//

import UIKit

class SortByTVC: UITableViewCell {

    @IBOutlet weak var sortByTitleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        sortByTitleLbl.font = .poppinsMedium(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
