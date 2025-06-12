//
//  RoomsListUprTableviewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 12/06/25.
//

import UIKit

class RoomsListUprTableviewCell : UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
    }

   
    
}
