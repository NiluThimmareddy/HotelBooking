//
//  HotelsListTVC.swift
//  HotelBooking
//
//  Created by toqsoft on 29/05/25.
//

import UIKit

class HotelsListTVC : UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hotelImgView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var hotelTypeLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var covidLabel: UILabel!
    @IBOutlet weak var phoneNoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
    }
    
    func configure(with hotel: Hotel, room: HotelRoom?, distance: String) {
        hotelNameLabel.text = hotel.HotelName
        hotelTypeLabel.text = hotel.HotelType
        descriptionLabel.text = hotel.Description
        addressLabel.text = hotel.City
        phoneNoLabel.text = hotel.PrimaryPhone
        covidLabel.text = hotel.CovidSafetyLevel
        distanceLabel.text = "\(distance)"

        if let room = room {
            priceLabel.text = "$\(room.basePrice)"
        } else {
            priceLabel.text = "N/A"
        }

        let rating = hotel.StarRating ?? 0.0
        ratingsView.rating = rating
        ratingsView.text = String(format: "%.1f", rating)
    }


}
