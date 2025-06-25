//
//  threeSixtyDegreeTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 20/06/25.
//

import UIKit

class ThreeSixtyDegreeTVC: UITableViewCell {

    @IBOutlet weak var hotelTitle: UILabel!
    @IBOutlet weak var imageData: UIImageView!
    @IBOutlet weak var backView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.BackViewShadow()
        imageData.BackViewShadow()
//        imageData.layer.masksToBounds = true
        imageData.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

      
    }
    
}
