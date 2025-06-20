//
//  HotelsListTVC.swift
//  HotelBooking
//
//  Created by toqsoft on 29/05/25.
//

import UIKit
import SkeletonView

class HotelsListTVC: UITableViewCell {
    
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
    @IBOutlet weak var adultsPriceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    @IBOutlet weak var cancelationPolicyLabel: UILabel!
    @IBOutlet weak var availabilityRoomsLabel: UILabel!
    @IBOutlet weak var originalPriceLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewTypeLabel: UILabel!
    @IBOutlet weak var totalReviewsCountLabel: UILabel!
    @IBOutlet weak var availableView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        isSkeletonable = true
        contentView.isSkeletonable = true
        backView.isSkeletonable = true
        availableView.isSkeletonable = true
        availableView.isHiddenWhenSkeletonIsActive = true

        ratingsView.isSkeletonable = true
        ratingsView.isHiddenWhenSkeletonIsActive = true

        makeAllSubviewsSkeletonable(in: contentView)
        
        backView.applyCardStyle()
    }

    func configure(with hotel: Hotel, room: HotelRoom?, policy: Policy, distance: HotelLandmark) {
        hotelNameLabel.text = hotel.HotelName
        hotelTypeLabel.text = hotel.HotelType
        descriptionLabel.text = hotel.Description
        addressLabel.text = "\(hotel.Country), \(hotel.StateOrProvince), \(hotel.City), \(hotel.AddressLine1), \(hotel.PostalCode)"
        phoneNoLabel.text = hotel.PrimaryPhone
        covidLabel.text = "CovidSafety Level : \(hotel.CovidSafetyLevel)"
        distanceLabel.text = "\(distance.distanceInKm) KM from \(distance.landmarkType)"
        availabilityRoomsLabel.text = "Available Rooms : \(room?.availableRooms ?? 0)"
        cancelationPolicyLabel.text = policy.PolicyType

        if let room = room {
            priceLabel.text = "$\(room.basePrice)"
        } else {
            priceLabel.text = "N/A"
        }

        let rating = hotel.StarRating ?? 0.0
        ratingsView.rating = rating
        ratingLabel.text = String(format: "%.1f", rating)
    }

    private func makeAllSubviewsSkeletonable(in view: UIView) {
        view.subviews.forEach {
            $0.isSkeletonable = true
            makeAllSubviewsSkeletonable(in: $0)
        }
    }
}

