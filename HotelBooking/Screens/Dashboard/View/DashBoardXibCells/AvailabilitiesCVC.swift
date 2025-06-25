//
//  AvailabilitiesCVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit

class AvailabilitiesCVC: UICollectionViewCell {

    @IBOutlet weak var labelBackView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var dataImage: UIImageView!
    @IBOutlet weak var imageBackView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.font = UIFont(name: "Poppins-Bold", size: 12)
        imageBackView.layer.cornerRadius = imageBackView.frame.size.width / 2
        labelBackView.layer.cornerRadius = 30
    }

}
