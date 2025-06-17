//
//  DetailsPageHotelImagesCVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit

class DetailsPageHotelImagesCVC: UICollectionViewCell {
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var hotelImageOne: UIImageView!
    @IBOutlet weak var hotelImageTwo: UIImageView!
    @IBOutlet weak var hotelImageThree: UIImageView!
    @IBOutlet weak var hotelImageFour: UIImageView!
    @IBOutlet weak var hotelImageFive: UIImageView!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var shadowViewButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowViewButton.alpha = 0.3
    }

}
