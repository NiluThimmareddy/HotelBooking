//
//  RecommendedRoomsLwrCVC.swift
//  HotelBooking
//
//  Created by toqsoft on 29/05/25.
//

import UIKit

class RecommendedRoomsLwrCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var roomImgView: UIImageView!
    @IBOutlet weak var bookNowButton: UIButton!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var roomsImages = ["room1","room2","room3","room4","room5","room6"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
    }

    @IBAction func bookNowButtonAction(_ sender: Any) {
    }
    
    func configure(with room: HotelRoom, index: Int) {
        roomTypeLabel.text = room.roomType
        priceLabel.text = "$\(room.basePrice)"

        let imageName = roomsImages[index % roomsImages.count] 
        roomImgView.image = UIImage(named: imageName)
    }
}
