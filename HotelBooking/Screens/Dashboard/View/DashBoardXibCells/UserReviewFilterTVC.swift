//
//  UserReviewFilterTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 04/06/25.
//

import UIKit

class UserReviewFilterTVC: UITableViewCell {

    @IBOutlet weak var downArrowOneImage: UIImageView!
    @IBOutlet weak var downArrowImage: UIImageView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var timeOfYearLbl: UILabel!
    @IBOutlet weak var filterByLbl: UILabel!
    @IBOutlet weak var seeAllCountReviews: UILabel!
    @IBOutlet weak var ratingContentLbl: UILabel!
    @IBOutlet weak var ratingLbl: UILabel!
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var reviewInsideTV: UITableView!
    
    var callGuestReview = [
        GuestReviewModel(name: "Cleanliness", rating: "8.5"),
        GuestReviewModel(name: "Comfort", rating: "9.0"),
        GuestReviewModel(name: "Facilities", rating: "8.8"),
        GuestReviewModel(name: "Value for Money", rating: "8.2"),
        GuestReviewModel(name: "Location", rating: "9.3")
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ratingLbl.layer.cornerRadius = 5
        ratingLbl.layer.masksToBounds = true
        reviewInsideTV.delegate = self
        reviewInsideTV.dataSource = self
        reviewInsideTV.register(UINib(nibName: "GuestReviewTVC", bundle: nil), forCellReuseIdentifier: "GuestReviewTVC")
        ratingLbl.font = .poppinsBold(14)
        ratingContentLbl.font = .poppinsBold(14)
        seeAllCountReviews.font = .poppinsMedium(10)
        filterByLbl.font = .poppinsBold(14)
        timeOfYearLbl.font = .poppinsMedium(12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}

extension UserReviewFilterTVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return callGuestReview.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GuestReviewTVC")as! GuestReviewTVC
        let data = callGuestReview[indexPath.row]
        cell.titleLbl.text = data.name
        cell.countLbl.text = data.rating
        let ratingValue = CGFloat((data.rating.replacingOccurrences(of: "%", with: "") as NSString).floatValue)
        
        DispatchQueue.main.async {
            let totalWidth = cell.progressViewBackView.frame.width
            let calculatedWidth = (ratingValue / 10.0) * totalWidth
            cell.progressViewWidthCons.constant = calculatedWidth
            
            
            cell.layoutIfNeeded()
        }
        return cell
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
            return 50
        
        }
    }
