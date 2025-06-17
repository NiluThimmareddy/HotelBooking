//
//  RoomTypeCVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 11/06/25.
//

import UIKit

class RoomTypeCVC: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.BackViewShadow()
    }

}
