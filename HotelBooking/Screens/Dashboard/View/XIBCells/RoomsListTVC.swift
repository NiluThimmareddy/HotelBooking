//
//  RoomsListTVC.swift
//  HotelBooking
//
//  Created by toqsoft on 09/07/25.
//

import UIKit
import SkeletonView

class RoomsListTVC : UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var topStackView: UIStackView!
    @IBOutlet weak var roomImagesView: UIImageView!
    @IBOutlet weak var amenitiesStackView: UIStackView!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var priceForNightLabel: UILabel!
    @IBOutlet weak var priceView: UIView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var offerLabel: UILabel!
    @IBOutlet weak var taxesLabel: UILabel!
    @IBOutlet weak var cancellationView: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectImagesButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isSkeletonable = true
        contentView.isSkeletonable = true
        backView.isSkeletonable = true
        
        makeAllSubviewsSkeletonable(in: contentView)
        
        backView.applyCardStyle()
    }

    @IBAction func selectRoomButtonAction(_ sender: Any) {
    }
    
    @IBAction func selectImagesButtonAction(_ sender: Any) {
    }
    
    func makeAllSubviewsSkeletonable(in view: UIView) {
        view.subviews.forEach {
            $0.isSkeletonable = true
            makeAllSubviewsSkeletonable(in: $0)
        }
    }
    
}
