//
//  RecommendedHotelsLwrCVC.swift
//  HotelBooking
//
//  Created by toqsoft on 03/06/25.
//

import UIKit

class RecommendedHotelsLwrCVC: UICollectionViewCell {
    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hotelImgView: UIImageView!
    @IBOutlet weak var hotelnameLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var ratingCountLabel: UILabel!
    @IBOutlet weak var ratingTypeLabel: UILabel!
    @IBOutlet weak var totalReviewsLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var startingPriceLabel: UILabel!
    
    var hotelimages = ["hotel_2","hotel_3","hotel_4","hotel_5","hotel_6","hotel_7"]
    var startingRate = ["$ 180.00","$ 190.00","$ 200.00","$ 210.00","$ 220.00","$230.00"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
        hotelImgView.clipsToBounds = true
        hotelImgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
//    func configure(with item: Hotel, index: Int) {
//        let imageName = hotelimages[index % hotelimages.count]
//        hotelImgView.image = UIImage(named: imageName)
//        hotelnameLabel.text = item.HotelName
//        countryLabel.text = item.Country
//                startingPriceLabel.text = startingRate[index % startingRate.count]
//        
//        let rating = item.StarRating ?? 0.0
//        ratingsView.rating = rating
//        ratingCountLabel.text = String(format: "%.1f", rating)
//    }
    
    func configure(with item: Hotel, index: Int) {
        let imageName = hotelimages[index % hotelimages.count]
        hotelImgView.image = UIImage(named: imageName)
        
        let rating = item.StarRating ?? 0.0
        let intRating = Int(rating)
        
        let hotelNameAttribute = NSMutableAttributedString(
            string: "\(item.HotelName) ",
            attributes: [.foregroundColor: UIColor.label]
        )
        
        if intRating > 0 && intRating <= 5 {
            let stars = String(repeating: "★", count: intRating)
            let starAttributedString = NSAttributedString(
                string: stars,
                attributes: [.foregroundColor: UIColor.systemYellow]
            )
            hotelNameAttribute.append(starAttributedString)
        }
        
        hotelnameLabel.attributedText = hotelNameAttribute
        
        countryLabel.text = item.Country
        startingPriceLabel.text = startingRate[index % startingRate.count]
        
        ratingsView.rating = rating
        ratingCountLabel.text = String(format: "%.1f", rating)
    }
}
