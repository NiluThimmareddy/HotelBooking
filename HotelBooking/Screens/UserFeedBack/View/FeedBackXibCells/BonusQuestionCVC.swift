//
//  BonusQuestionCVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 16/06/25.
//

import UIKit

class BonusQuestionCVC: UICollectionViewCell {
    
    @IBOutlet weak var ratingFiveButton: UIButton!
    @IBOutlet weak var ratingFourButton: UIButton!
    @IBOutlet weak var ratingThreeButton: UIButton!
    @IBOutlet weak var ratingTwoButton: UIButton!
    @IBOutlet weak var ratingOneButton: UIButton!
    @IBOutlet weak var questionTitle: UILabel!
    
    var onRatingSelected: ((Int) -> Void)?
    var color = UIColor(named: "defaultColor")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        questionTitle.font = .poppinsMedium(12)
    }
    @IBAction func RatingButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        onRatingSelected?(selectedRating)
        
        for i in 1...5 {
            if let button = contentView.viewWithTag(i) as? UIButton {
                button.tintColor = (i == selectedRating) ? color : .lightGray
            }
        }
    }
    
}
