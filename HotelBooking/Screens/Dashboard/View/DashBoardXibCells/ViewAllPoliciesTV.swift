//
//  ViewAllPoliciesTV.swift
//  HotelBooking
//
//  Created by praveenkumar on 16/07/25.
//

import UIKit

class ViewAllPoliciesTV: UITableViewCell {

    @IBOutlet weak var otherPoliciesView: UIView!
    @IBOutlet weak var otherPoliciesContent: UILabel!
    @IBOutlet weak var otherPoliciesTitle: UILabel!
    @IBOutlet weak var otherPolicisImages: UIImageView!
   
  

    override func awakeFromNib() {
        super.awakeFromNib()
        font()
    }
    
    func font(){
        otherPoliciesTitle.font = UIFont.poppinsBold(16)
        otherPoliciesContent.font = UIFont.poppinsMedium(12)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}

