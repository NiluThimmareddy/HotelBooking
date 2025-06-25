//
//  OneToTenRatingCVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 16/06/25.
//

import UIKit

class OneToTenRatingCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var oneToTenRatingButton: UIButton!
    var onButtonTapped: (() -> Void)?
    override func awakeFromNib() {
        super.awakeFromNib()
//      styleBackView(backView)
    }

    @IBAction func oneToTenRatingButton(_ sender: Any) {
        onButtonTapped?()
    }
    func styleBackView(_ view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.clipsToBounds = true
    }

}
