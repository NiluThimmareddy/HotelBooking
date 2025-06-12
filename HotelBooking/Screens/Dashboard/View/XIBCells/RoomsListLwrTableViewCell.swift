//
//  RoomsListLwrTableViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 10/06/25.
//


import UIKit

class RoomsListLwrTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var partnerView: UIView!
    @IBOutlet weak var rateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
        
        DispatchQueue.main.async {
            self.partnerView.addBorder(edge: .right, color: .darkGray, thickness: 0.8)
            self.rateView.addBorder(edge: .left, color: .darkGray, thickness: 0.8)
        }
    }

}


