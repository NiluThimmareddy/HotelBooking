//
//  UserReviewsVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 04/06/25.
//

import UIKit

class UserReviewsVC: UIViewController {
    
    @IBOutlet weak var sortByCloseButton: UIButton!
    @IBOutlet weak var sortByCloseView: UIView!
    @IBOutlet weak var filterByCloseButtob: UIButton!
    @IBOutlet weak var filterByCloseView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var GuestReviewTitle: UILabel!
    @IBOutlet weak var sortByTitle: UILabel!
    @IBOutlet weak var filterByTitle: UILabel!
    @IBOutlet weak var sortByTV: UITableView!
    @IBOutlet weak var sortByBackView: UIView!
    @IBOutlet weak var filterByBackView: UIView!
    @IBOutlet weak var filterByTableView: UITableView!
    @IBOutlet weak var reviewFilterTableViewHeightCons: NSLayoutConstraint! //default height is 150
    @IBOutlet weak var hotelNameLbl: UILabel!
    @IBOutlet weak var scrollViewContentViewHightCons: NSLayoutConstraint!
    @IBOutlet weak var GuestWhoStayedHereTVHeightCons: NSLayoutConstraint!
    @IBOutlet weak var userReviewTableView: UITableView!
    @IBOutlet weak var reviewFilterTableView: UITableView!
    
    var isFirstFilterCellExpanded = false
    let countryViewModel = CountryListViewModel()
    var callUserReview = [
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "Aisha Khan", image: "man", desc: "Amazing food and great hospitality. Would come again!", country: "United States"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "Aisha Khan", image: "man", desc: "Amazing food and great hospitality. Would come again!", country: "United States"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "Aisha Khan", image: "man", desc: "Amazing food and great hospitality. Would come again!", country: "United States"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "Aisha Khan", image: "man", desc: "Amazing food and great hospitality. Would come again!", country: "United States"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India")
    ]
    var filterDate = ["Mar - May","Jun - Aug","Sep - Nov","Dec - Feb"]
    var sortedData = ["Most Relevant","Newest First","Oldest First","Highest Scores","Lowest Scores"]
    var hotelName: String?
    let topNameLbl: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.text = "Review"
       label.font = UIFont.poppinsBold(16)
       label.textAlignment = .center
       return label
   }()
    let color = UIColor(named: "defaultColor")
    override func viewDidLoad() {
        super.viewDidLoad()
        CountryCodeManager.shared.fetchCountryCodes {
                DispatchQueue.main.async {
                    self.userReviewTableView.reloadData()
                }
            }
        userReviewTableView.register(UINib(nibName: "GuestWhoStayedHereTVC", bundle: nil), forCellReuseIdentifier: "GuestWhoStayedHereTVC")
        reviewFilterTableView.register(UINib(nibName: "UserReviewFilterTVC", bundle: nil), forCellReuseIdentifier: "UserReviewFilterTVC")
        filterByTableView.register(UINib(nibName: "FilterByDateTVC", bundle: nil), forCellReuseIdentifier: "FilterByDateTVC")
        sortByTV.register(UINib(nibName: "SortByTVC", bundle: nil), forCellReuseIdentifier: "SortByTVC")
       
        filterByBackView.BackViewShadow()
        sortByBackView.BackViewShadow()
        hotelNameLbl.text = hotelName
        navigationItem.titleView = topNameLbl
        fontStyle()
        filterByCloseView.isHidden = true
        sortByCloseView.isHidden = true
        filterByCloseButtob.alpha = 0.2
        sortByCloseButton.alpha = 0.2
    }
   

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDynamicHeights()
    }
    func updateDynamicHeights() {
        let maxUserReviewCount = callUserReview.count
        let guestWhoStayedHeight = CGFloat(maxUserReviewCount) * 100
        GuestWhoStayedHereTVHeightCons.constant = guestWhoStayedHeight
        let baseContentHeight: CGFloat = 440
        scrollViewContentViewHightCons.constant = baseContentHeight +  guestWhoStayedHeight
        view.layoutIfNeeded()
    }
    func fontStyle(){
        sortByTitle.font = .poppinsBold(14)
        filterByTitle.font = .poppinsBold(14)
        GuestReviewTitle.font = .poppinsBold(14)
        let apply = NSAttributedString(
            string: "Apply",
            attributes: [.font: UIFont.poppinsBold(14), .foregroundColor: color ?? UIColor.blue]
        )
        applyButton.setAttributedTitle(apply, for: .normal)
        let cancel = NSAttributedString(
            string: "Cancel",
            attributes: [.font: UIFont.poppinsBold(14), .foregroundColor: color ?? UIColor.blue]
        )
        cancelButton.setAttributedTitle(cancel, for: .normal)
        hotelNameLbl.font = .poppinsBold(14)
    }
   
    @IBAction func filterByApplyButton(_ sender: Any) {
    }
    @IBAction func filterByCancelButto(_ sender: Any) {
        filterByCloseView.isHidden = true
        sortByCloseView.isHidden = true
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func filterByCloseButton(_ sender: Any) {
        filterByCloseView.isHidden = true
        sortByCloseView.isHidden = true
    }
    @IBAction func sortByCloseButton(_ sender: Any) {
        filterByCloseView.isHidden = true
        sortByCloseView.isHidden = true
    }
}

extension UserReviewsVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == reviewFilterTableView{
            return 3
        }else if tableView == userReviewTableView{
            return callUserReview.count
        }else if tableView == filterByTableView{
            return filterDate.count
        }else{
            return sortedData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == reviewFilterTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserReviewFilterTVC") as! UserReviewFilterTVC
            switch indexPath.row {
            case 0:
                cell.ratingLbl.text = "3"
                cell.ratingContentLbl.text = "Excellent"
                cell.seeAllCountReviews.text = "See All 3 Reviews"
                cell.filterView.isHidden = true
                cell.ratingView.isHidden = false
                cell.downArrowOneImage.isHidden =  true
            case 1:
                cell.filterByLbl.text = "Filter by : "
                cell.timeOfYearLbl.text = "Time of Year"
                cell.filterView.isHidden = false
                cell.ratingView.isHidden = true
            case 2:
                cell.filterByLbl.text = "Sort by   : "
                cell.timeOfYearLbl.text = "Most Relevant"
                cell.filterView.isHidden = false
                cell.ratingView.isHidden = true
            default:
                break
            }
            
            
            return cell
        }else if tableView == userReviewTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GuestWhoStayedHereTVC") as! GuestWhoStayedHereTVC
            let data = callUserReview[indexPath.row]
            let matchData = countryViewModel.countries.filter({$0.name == data.country})
            
            print("Matched Data: \(matchData.first?.name ?? "")")
            let countryName = data.country.lowercased()
            if let countryCode = CountryCodeManager.shared.nameToCode[countryName] {
                let flagUrl = "https://flagsapi.com/\(countryCode.uppercased())/flat/64.png"
                print("🌍 Flag URL: \(flagUrl)")
                if let url = URL(string: flagUrl) {
                    DispatchQueue.global().async {
                        if let data = try? Data(contentsOf: url),
                           let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                cell.countryImage.image = image
                            }
                        } else {
                            DispatchQueue.main.async {
                                cell.countryImage.image = UIImage(systemName: "photo")
                            }
                        }
                    }
                } else {
                    cell.countryImage.image = UIImage(systemName: "photo")
                }
            }
            cell.userName.text = data.name
            cell.userImage.image = UIImage(named: data.image)
            cell.userCountry.text = data.country
            cell.userReview.text = data.desc
            return cell
        }else if tableView == filterByTableView{
            let cell = tableView.dequeueReusableCell(withIdentifier: "FilterByDateTVC") as! FilterByDateTVC
            cell.titleLbl.text = filterDate[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SortByTVC") as! SortByTVC
            cell.sortByTitleLbl.text = sortedData[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == reviewFilterTableView {
            if indexPath.row == 0 {
                return  300
            }
            return 50
        } else if tableView == userReviewTableView{
            return 100
        }else if tableView == filterByTableView{
            return 50
        }else{
            return 50
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == reviewFilterTableView {
             if indexPath.row == 1{
                filterByCloseView.isHidden = false
                sortByCloseView.isHidden = true
            }else if indexPath.row == 2{
                filterByCloseView.isHidden = true
                sortByCloseView.isHidden = false
            }
        }
    }
}
