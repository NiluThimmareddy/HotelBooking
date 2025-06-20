//
//  RoomOffersCollectionViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 10/06/25.
//

import UIKit
import SkeletonView

class RoomOffersCollectionViewCell : UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var offerOneView: UIView!
    @IBOutlet weak var offer2View: UIView!
    @IBOutlet weak var offer3View: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        isSkeletonable = true
        contentView.isSkeletonable = true
        
        [backView, priceLabel,offerOneView,offer2View,offer3View].forEach {
            $0?.isSkeletonable = true
        }
        
        [offerOneView,offer2View,offer3View].forEach {
            $0?.isHiddenWhenSkeletonIsActive = true
        }
        contentView.makeAllSubviewsSkeletonable()
        backView.applyCardStyle()
    }

}
