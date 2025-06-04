//
//  GuestWhoStayedHereTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 29/05/25.
//

import UIKit

class GuestWhoStayedHereTVC: UITableViewCell {

    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var userCountry: UILabel!
    @IBOutlet weak var userReview: UILabel!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        userImage.layer.cornerRadius = userImage.frame.size.height / 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
