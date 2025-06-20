//
//  RoomsListLwrTableViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 10/06/25.
//

/*
import UIKit

class RoomsListLwrTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var partnerView: UIView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var bedsCountLabel: UILabel!
    @IBOutlet weak var roomSizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
        
        DispatchQueue.main.async {
            self.partnerView.addBorder(edge: .right, color: .darkGray, thickness: 0.8)
            self.rateView.addBorder(edge: .left, color: .darkGray, thickness: 0.8)
        }
    }

}

*/

import UIKit
import SkeletonView

class RoomsListLwrTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var partnerView: UIView!
    @IBOutlet weak var rateView: UIView!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var bedsCountLabel: UILabel!
    @IBOutlet weak var roomSizeLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        isSkeletonable = true
        contentView.isSkeletonable = true
        
        
        [backView, partnerView, rateView, roomTypeLabel, adultsCountLabel, bedsCountLabel, roomSizeLabel, priceLabel].forEach {
            $0?.isSkeletonable = true
        }
        contentView.makeAllSubviewsSkeletonable()
        backView.applyCardStyle()

        DispatchQueue.main.async {
            self.partnerView.addBorder(edge: .right, color: .darkGray, thickness: 0.8)
            self.rateView.addBorder(edge: .left, color: .darkGray, thickness: 0.8)
        }
    }
}

