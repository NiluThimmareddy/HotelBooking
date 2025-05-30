//
//  PropertyTypeCVC.swift
//  HotelBooking
//
//  Created by toqsoft on 29/05/25.
//

import UIKit

class PropertyTypeCVC : UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var propertyImgView: UIImageView!
    @IBOutlet weak var propertyType: UILabel!
    
    var hotelimages = ["hotel_6","hotel_3","hotel_5","hotel_4","hotel_7","hotel_2"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
    }
    
    func configure(with item: Hotel, index: Int) {
        let imageName = hotelimages[index % hotelimages.count]
        propertyImgView.image = UIImage(named: imageName)
        propertyType.text = item.HotelType
    }
}
