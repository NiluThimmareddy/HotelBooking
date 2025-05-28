//
//  AvailabilitiesCVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit

class AvailabilitiesCVC: UICollectionViewCell {

    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var imageBackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackView.layer.cornerRadius = imageBackView.frame.size.width / 2
    }

}
