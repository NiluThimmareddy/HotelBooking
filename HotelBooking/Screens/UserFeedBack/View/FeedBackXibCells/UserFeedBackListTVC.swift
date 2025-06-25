//
//  UserFeedBackListTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 18/06/25.
//

import UIKit

class UserFeedBackListTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var completeReviewLbl: UILabel!
    @IBOutlet weak var howManyDaysLeftToGiveReview: UILabel!
    @IBOutlet weak var bookedDate: UILabel!
    @IBOutlet weak var hotelLocation: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var draftLbl: UILabel!
    @IBOutlet weak var hotelImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.BackViewShadow()
        hotelImage.layer.cornerRadius = 10
        draftLbl.layer.cornerRadius = 5
        draftLbl.layer.borderWidth = 2
        draftLbl.layer.borderColor = UIColor.lightGray.cgColor
        fontStyle()
    }
    func fontStyle(){
        draftLbl.font = .poppinsMedium(10)
        hotelName.font = .poppinsBold(14)
        hotelLocation.font = .poppinsMedium(12)
        bookedDate.font = .poppinsMedium(12)
        howManyDaysLeftToGiveReview.font = .poppinsMedium(10 )
        completeReviewLbl.font = .poppinsBold(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    
}
