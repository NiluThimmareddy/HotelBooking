//
//  popularPlacesCVC.swift
//  HotelBooking
//
//  Created by toqsoft on 24/06/25.
//

import UIKit

class popularPlacesCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var hotelImageView: UIImageView!
    @IBOutlet weak var popularPlaceLabel: UILabel!
    
    
    var hotelimages = ["hotel_3","hotel_5","hotel_2","hotel_6","hotel_7","hotel_4"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with room: Hotel, index: Int) {
        popularPlaceLabel.text = room.City

        let imageName = hotelimages[index % hotelimages.count]
        hotelImageView.image = UIImage(named: imageName)
    }
    
}
