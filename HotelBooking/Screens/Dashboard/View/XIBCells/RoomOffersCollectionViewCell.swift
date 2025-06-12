//
//  RoomOffersCollectionViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 10/06/25.
//

import UIKit

class RoomOffersCollectionViewCell : UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
    }

}
