//
//  UserFeedBackListVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 18/06/25.
//

import UIKit

class UserFeedBackListVC: UIViewController {

    @IBOutlet weak var feedBackListTV: UITableView!
    
    var callHotelFeedBack = [
        HotelFeedBackInfo(hotelImage: "1", hotelName: "Taj", bookedDate: "15 - 16 May 2025", hotelLocation: "Chennai", status: "Completed", process: "Done"),
        HotelFeedBackInfo(hotelImage: "2",hotelName: "Chola", bookedDate: "15 - 16 June 2025",hotelLocation: "Chennai",status: "Pending",process: "Draft")
    ]
    
    let topNameLbl: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.text = "Your Reviews"
       label.font = UIFont.poppinsBold(16)
       label.textAlignment = .center
       return label
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
        feedBackListTV.register(UINib(nibName: "UserFeedBackListTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackListTVC")
        feedBackListTV.showsVerticalScrollIndicator = false
        feedBackListTV.showsHorizontalScrollIndicator = false
        navigationItem.titleView = topNameLbl
    }
    
    
   
    
}

extension UserFeedBackListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return callHotelFeedBack.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFeedBackListTVC")as! UserFeedBackListTVC
        let data = callHotelFeedBack[indexPath.row]
        cell.bookedDate.text = data.bookedDate
        cell.hotelName.text = data.hotelName
        cell.hotelImage.image = UIImage(named: data.hotelImage)
        cell.hotelLocation.text = data.hotelLocation
        if data.process == "Draft"{
            cell.draftLbl.text = data.process
            cell.draftLbl.textColor = .darkGray
            cell.draftLbl.layer.borderColor = UIColor.lightGray.cgColor
        }else{
            cell.draftLbl.text = data.process
            cell.draftLbl.textColor = .systemGreen
            cell.draftLbl.layer.borderColor = UIColor.systemGreen.cgColor
        }
        if data.status == "Pending"{
            cell.completeReviewLbl.text = "Complete your draft review"
            cell.howManyDaysLeftToGiveReview.text = data.daysRemaining
        }else{
            cell.completeReviewLbl.text = "Review Completed"
            cell.howManyDaysLeftToGiveReview.text = "Thanks for your useful Feedback"
        }
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = callHotelFeedBack[indexPath.row]
        if data.status == "Pending"{
            let controller = UIStoryboard(name: "Review", bundle: nil).instantiateViewController(withIdentifier: "PostReviewViewController") as! PostReviewViewController
            let backItem = UIBarButtonItem()
            backItem.title = ""
            self.navigationItem.backBarButtonItem = backItem
            self.navigationController?.navigationBar.tintColor = .white
            self.navigationController?.pushViewController(controller, animated: true)
        }else{
            self.showAlert(
                        title: "Feedback Completed",
                        message: "You have already submitted feedback for this booking.",
                        type: .info
                    )
        }
        
    }
}
