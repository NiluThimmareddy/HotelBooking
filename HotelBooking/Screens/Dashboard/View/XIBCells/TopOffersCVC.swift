//
//  TopOffersCVC.swift
//  HotelBooking
//
//  Created by toqsoft on 22/05/25.
//


import UIKit

class TopOffersCVC: UICollectionViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var bankImageView: UIImageView!
    @IBOutlet weak var percentLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var offerCodeLabel: UILabel!
    
    private var aspectRatioConstraint: NSLayoutConstraint?

    override func awakeFromNib() {
        super.awakeFromNib()
        backView.applyCardStyle()
        bankImageView.contentMode = .scaleAspectFit
    }

    func configure(viewModel: HotelJsonViewModel, index: Int) {
        guard index < viewModel.bankImages.count,
              let image = UIImage(named: viewModel.bankImages[index]) else {
            bankImageView.image = nil
            return
        }

        bankImageView.image = image

        if let oldConstraint = aspectRatioConstraint {
            bankImageView.removeConstraint(oldConstraint)
        }

        let aspectRatio = image.size.width / image.size.height
        aspectRatioConstraint = bankImageView.widthAnchor.constraint(equalTo: bankImageView.heightAnchor, multiplier: aspectRatio)
        aspectRatioConstraint?.priority = .required
        aspectRatioConstraint?.isActive = true

        percentLabel.text = viewModel.percentage[safe: index] ?? ""
        descriptionLabel.text = viewModel.descriptions[safe: index] ?? ""

        let code = viewModel.offerCode[safe: index] ?? ""
        offerCodeLabel.text = code
        offerCodeLabel.isHidden = code.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

}


