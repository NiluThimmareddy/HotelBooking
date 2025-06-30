//
//  SearchListTableViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 30/06/25.
//

import UIKit

class SearchListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
        backView.layer.cornerRadius = 8
        backView.layer.shadowOpacity = 0.2
        backView.layer.shadowRadius = 4
        backView.layer.shadowColor = UIColor.black.cgColor
        backView.layer.shadowOffset = CGSize(width: 0, height: 2)
    }
    
}
