//
//  GuestReviewTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 29/05/25.
//

import UIKit

class GuestReviewTVC: UITableViewCell {

    @IBOutlet weak var progressViewWidthCons: NSLayoutConstraint!
    @IBOutlet weak var progressView: UIView!
    @IBOutlet weak var progressViewBackView: UIView!
    @IBOutlet weak var countLbl: UILabel!
    @IBOutlet weak var titleLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
