//
//  RoomsListTVC.swift
//  HotelBooking
//
//  Created by toqsoft on 09/07/25.
//

import UIKit
import SkeletonView

protocol RoomsListTVCDelegate: AnyObject {
    func didTapSelectImagesButton(in cell: RoomsListTVC)
    func didTapSelectRoom(in cell: RoomsListTVC, room: HotelRoom)
}

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
    @IBOutlet weak var cancellationLabel: UILabel!
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var selectImagesButton: UIButton!
    @IBOutlet weak var bedsCountLabel: UILabel!
    @IBOutlet weak var roomSizeLabel: UILabel!
    @IBOutlet weak var adultsCountLabel: UILabel!
    
    weak var delegate: RoomsListTVCDelegate?
    var currentRoom: HotelRoom?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        isSkeletonable = true
        contentView.isSkeletonable = true
        backView.isSkeletonable = true
        
        makeAllSubviewsSkeletonable(in: contentView)
        
        backView.applyCardStyle()
    }
    
    @IBAction func selectRoomButtonAction(_ sender: Any) {
        if let room = currentRoom {
            delegate?.didTapSelectRoom(in: self, room: room)
        }
    }
    
    @IBAction func selectImagesButtonAction(_ sender: Any) {
        delegate?.didTapSelectImagesButton(in: self)
    }
    
    func makeAllSubviewsSkeletonable(in view: UIView) {
        view.subviews.forEach {
            $0.isSkeletonable = true
            makeAllSubviewsSkeletonable(in: $0)
        }
    }
    
    func configure(with room : HotelRoom) {
        self.currentRoom = room
        roomTypeLabel.text = room.roomName
        bedsCountLabel.text = "\(room.bedType)"
        roomSizeLabel.text = room.roomSize
        adultsCountLabel.text = "\(room.maxAdults) adults, \(room.maxChildren) children"
        priceLabel.text = "$ \(room.basePrice)"
        cancellationLabel.text = room.refundPolicy
    }
    
}
