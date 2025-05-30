//
//  RecommendedHotelsCVC.swift
//  HotelBooking
//
//  Created by toqsoft on 29/05/25.
//

import UIKit

class RecommendedHotelsCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var addressLabel: UILabel!
    
    var hotelimages = ["hotel_2","hotel_3","hotel_4","hotel_5","hotel_6","hotel_7"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
        hotelImageView.clipsToBounds = true
        hotelImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func configure(with item: Hotel, index: Int) {
        let imageName = hotelimages[index % hotelimages.count]
        hotelImageView.image = UIImage(named: imageName)
        hotelNameLabel.text = item.HotelName
        addressLabel.text = item.Country
        
        let rating = item.StarRating ?? 0.0
        ratingView.rating = rating
        ratingView.text = String(format: "%.1f", rating)
    }
}
