//
//  topAttractionTV.swift
//  HotelBooking
//
//  Created by praveenkumar on 23/06/25.
//

import UIKit

class TopAttractionTVC: UITableViewCell {

    @IBOutlet weak var kmLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        kmLbl.font = .poppinsMedium(12)
        titleLbl.font = .poppinsMedium(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
