//
//  HotelListPageTVC.swift
//  HotelBooking
//
//  Created by toqsoft on 28/05/25.
//

import UIKit

class HotelListPageTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var hotelTypeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    @IBOutlet weak var covidLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
    }
    
    func configure(with item : Hotel) {
        hotelNameLabel.text = item.HotelName
        hotelTypeLabel.text = item.HotelType
        descriptionLabel.text = item.Description
        addressLabel.text = item.City
        phoneNoLabel.text = item.PrimaryPhone
        covidLabel.text = item.CovidSafetyLevel
    }

}
