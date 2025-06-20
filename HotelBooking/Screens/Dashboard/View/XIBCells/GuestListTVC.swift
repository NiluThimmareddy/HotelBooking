//
//  GuestListTVC.swift
//  HotelBooking
//
//  Created by toqsoft on 19/06/25.
//

import UIKit

protocol GuestListCellDelegate: AnyObject {
    func didTapEditButton(in cell: GuestListTVC)
    func didTapSelectButton(in cell: GuestListTVC)
}

class GuestListTVC: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var guestNameLabel: UILabel!
    @IBOutlet weak var editGuestButton: UIButton!
    
    weak var delegate: GuestListCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backView.addTopShadow()
    }
    
    @IBAction func selectButtonAction(_ sender: Any) {
        print("Select button tapped")
        delegate?.didTapSelectButton(in: self)
    }
    
    @IBAction func editGuestButtonAction(_ sender: Any) {
        delegate?.didTapEditButton(in: self)
    }
    
}
