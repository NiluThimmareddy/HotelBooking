//
//  SortFilterTableViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 11/06/25.
//

import UIKit

class SortFilterTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    
    var buttonAction: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    @IBAction func selectButtonAction(_ sender: Any) {
        buttonAction?()
    }
}

