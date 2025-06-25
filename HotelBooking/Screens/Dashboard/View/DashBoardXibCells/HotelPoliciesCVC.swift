//
//  HotelPoliciesCVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit

class HotelPoliciesCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLbl.font = UIFont(name: "Poppins-Medium", size: 12)
    }

}
