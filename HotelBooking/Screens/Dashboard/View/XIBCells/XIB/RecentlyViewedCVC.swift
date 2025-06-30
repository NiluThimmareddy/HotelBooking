//
//  RecentlyViewedCVC.swift
//  HotelBooking
//
//  Created by toqsoft on 24/06/25.
//

import UIKit

class RecentlyViewedCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hotelImgView: UIImageView!
    @IBOutlet weak var hotelNameLabel: UILabel!
    
    var hotelimages = ["hotel_2","hotel_3","hotel_4","hotel_5","hotel_6","hotel_7"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with room: Hotel, index: Int) {
        hotelNameLabel.text = "\(room.HotelType), \(room.City)"

        let imageName = hotelimages[index % hotelimages.count]
        hotelImgView.image = UIImage(named: imageName)
    }
}
