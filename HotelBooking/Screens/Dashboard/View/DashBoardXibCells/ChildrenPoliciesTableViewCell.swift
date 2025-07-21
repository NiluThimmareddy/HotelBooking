//
//  ChildrenPoliciesTableViewCell.swift
//  HotelBooking
//
//  Created by praveenkumar on 16/07/25.
//

import UIKit

class ChildrenPoliciesTableViewCell: UITableViewCell {

    @IBOutlet weak var fromAge: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var amountLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        font()
    }
    func font(){
        fromAge.font = UIFont.poppinsBold(14)
        amountLbl.font = UIFont.poppinsMedium(14)
        contentLbl.font = UIFont.poppinsMedium(14)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}
