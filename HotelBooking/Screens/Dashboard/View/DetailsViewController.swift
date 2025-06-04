//
//  DetailsViewController.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit
import MapKit


struct AvailabilitiesModel{
    let name: String
    let image: String
}
struct userReviewModel{
    let name: String
    let image: String
    let desc: String
    let country: String
    
}
struct GuestReviewModel{
    let name: String
    let rating: String
}
class DetailsViewController: UIViewController,UIScrollViewDelegate {
    
    
    
    
    @IBOutlet weak var guestWhoStayedHereLovedViewAllButton: UIButton!
    @IBOutlet weak var importantInformationReadMoreButton: UIButton!
    @IBOutlet weak var importantInformationLblHeightCons: NSLayoutConstraint!
    @IBOutlet weak var importantInformationLbl: UILabel!
    @IBOutlet weak var transportBackView: UIView!
    @IBOutlet weak var eatAndDrinkBackView: UIView!
    @IBOutlet weak var topAttrocitiesBackView: UIView!
    @IBOutlet weak var transportButton: UIButton!
    @IBOutlet weak var transportDownView: UIView!
    @IBOutlet weak var eatAndDrinkDownView: UIView!
    @IBOutlet weak var eatAndDrinkButton: UIButton!
    @IBOutlet weak var attractionButton: UIButton!
    @IBOutlet weak var attractionDownView: UIView!
    @IBOutlet weak var popularSurroundingBackView: UIView!
    @IBOutlet weak var GuestWhoStayedHereTVHeightCons: NSLayoutConstraint!
    @IBOutlet weak var GuestWhoStayedHereTV: UITableView!
    @IBOutlet weak var scrollContentView: UIView!
    @IBOutlet weak var scrollViewContentViewHightCons: NSLayoutConstraint!
    @IBOutlet weak var guestReviewTVHightCons: NSLayoutConstraint!
    @IBOutlet weak var showMoreButton: UIButton!
    @IBOutlet weak var highScoreForStateLbl: UILabel!
    @IBOutlet weak var guestReviewTV: UITableView!
    @IBOutlet weak var guestReviewRatingCountLbl: UILabel!
    @IBOutlet weak var guestReviewRatingLbl: UILabel!
    @IBOutlet weak var policiesCollectionView: UICollectionView!
    @IBOutlet weak var aboutThisHotelDescP: UILabel!
    @IBOutlet weak var scrollViewScroll: UIScrollView!
    @IBOutlet weak var geniusDiscountLbl: UILabel!
    @IBOutlet weak var mapKitViewLatitudeLocation: MKMapView!
    @IBOutlet weak var noCreditCardNeededView: UIView!
    @IBOutlet weak var summerOfferLbl: UILabel!
    @IBOutlet weak var offerPercentageLbl: UILabel!
    @IBOutlet weak var taxesAndChargesLbl: UILabel!
    @IBOutlet weak var actualPriceLbl: UILabel!
    @IBOutlet weak var priceStrikeLbl: UILabel!
    @IBOutlet weak var priceForLbl: UILabel!
    @IBOutlet weak var roomsAndGuestLbl: UILabel!
    @IBOutlet weak var checkInLbl: UILabel!
    @IBOutlet weak var checkOutLbl: UILabel!
    @IBOutlet weak var availabilitiesCollectionView: UICollectionView!
    @IBOutlet weak var hotelImagesCollectionView: UICollectionView!
    @IBOutlet weak var hotelRatingLbl: UILabel!
    @IBOutlet weak var hotelNameLBL: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var topNameLbl: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var currentIndex = 0
    let countryViewModel = CountryListViewModel()
    let viewModel = HotelJsonViewModel()
    var callAvailabilities = [AvailabilitiesModel(name: "wellness", image: "wellness"),
                              AvailabilitiesModel(name: "dining", image: "dining"),
                              AvailabilitiesModel(name: "entertainment", image: "entertainment"),
                              AvailabilitiesModel(name: "business", image: "business")]
    var callUserReview = [
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "Aisha Khan", image: "man", desc: "Amazing food and great hospitality. Would come again!", country: "United States"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India"),
        userReviewModel(name: "Aisha Khan", image: "man", desc: "Amazing food and great hospitality. Would come again!", country: "United States"),
        userReviewModel(name: "John Doe", image: "profile", desc: "Had a wonderful stay, very clean and comfortable.", country: "India")
    ]
    var callGuestReview = [
        GuestReviewModel(name: "Cleanliness", rating: "8.5"),
        GuestReviewModel(name: "Comfort", rating: "9.0"),
        GuestReviewModel(name: "Facilities", rating: "8.8"),
        GuestReviewModel(name: "Value for Money", rating: "8.2"),
        GuestReviewModel(name: "Location", rating: "9.3")
    ]

    var hotelImages = ["1","2","3","4","5","6","7","8","9","10","11"]
    var policies = ["Cancellation","Child","Comfort","Pet"]
   
    var isGuestReviewExpanded = false

    override func viewDidLoad() {
        super.viewDidLoad()
        CountryCodeManager.shared.fetchCountryCodes {
                DispatchQueue.main.async {
                    self.GuestWhoStayedHereTV.reloadData()
                }
            }
        hideViewAllButton()
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeft.direction = .left
        popularSurroundingBackView.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRight.direction = .right
        popularSurroundingBackView.addGestureRecognizer(swipeRight)

        popularSurroundingBackView.isUserInteractionEnabled = true

        
        attractionDownView.isHidden = false
        eatAndDrinkDownView.isHidden = true
        transportDownView.isHidden = true
        topAttrocitiesBackView.isHidden = false
        eatAndDrinkBackView.isHidden = true
        transportBackView.isHidden = true
        
        callData()
        countryViewModel.fetchCountries()
        hotelImagesCollectionView.register(UINib(nibName: "DetailsPageHotelImagesCVC", bundle: nil), forCellWithReuseIdentifier: "DetailsPageHotelImagesCVC")
        availabilitiesCollectionView.register(UINib(nibName: "AvailabilitiesCVC", bundle: nil), forCellWithReuseIdentifier: "AvailabilitiesCVC")
        policiesCollectionView.register(UINib(nibName: "HotelPoliciesCVC", bundle: nil), forCellWithReuseIdentifier: "HotelPoliciesCVC")
        
        guestReviewTV.delegate = self
        guestReviewTV.dataSource = self
        GuestWhoStayedHereTV.delegate = self
        GuestWhoStayedHereTV.dataSource = self
        guestReviewTV.register(UINib(nibName: "GuestReviewTVC", bundle: nil), forCellReuseIdentifier: "GuestReviewTVC")
        GuestWhoStayedHereTV.register(UINib(nibName: "GuestWhoStayedHereTVC", bundle: nil), forCellReuseIdentifier: "GuestWhoStayedHereTVC")
        
        noCreditCardNeededView.layer.cornerRadius = 10
        noCreditCardNeededView.layer.borderWidth = 2
        noCreditCardNeededView.layer.borderColor = UIColor.lightGray.cgColor
        
        summerOfferLbl.layer.cornerRadius = 5
        summerOfferLbl.clipsToBounds = true

        offerPercentageLbl.layer.cornerRadius = 5
        offerPercentageLbl.clipsToBounds = true
        
        guestReviewRatingLbl.layer.cornerRadius = 5
        guestReviewRatingLbl.clipsToBounds = true
        
        geniusDiscountLbl.layer.cornerRadius = 5
        geniusDiscountLbl.clipsToBounds = true
        
        hotelRatingLbl.layer.cornerRadius = 5
        hotelRatingLbl.clipsToBounds = true

        locationWithPin()
        mapKitViewLatitudeLocation.layer.cornerRadius = 10
        topNameLbl.text = ""
        scrollViewScroll.delegate = self

        let originalPrice = "Rs 2808"
        let attributedString = NSAttributedString(
            string: originalPrice,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                
            ]
        )

        priceStrikeLbl.attributedText = attributedString
        
    }
    func hideViewAllButton(){
        let maxUserReviewCount = callUserReview.count
        if maxUserReviewCount > 5{
            guestWhoStayedHereLovedViewAllButton.isHidden = false
            
        }else{
            guestWhoStayedHereLovedViewAllButton.isHidden = true
           
        }
    }
    @objc func handleSwipe(_ gesture: UISwipeGestureRecognizer) {
        if gesture.direction == .left {
            if currentIndex < 2 {
                currentIndex += 1
                switchToCategory(index: currentIndex)
            }
        } else if gesture.direction == .right {
            if currentIndex > 0 {
                currentIndex -= 1
                switchToCategory(index: currentIndex)
            }
        }
    }
    func switchToCategory(index: Int) {
        attractionDownView.isHidden = index != 0
        eatAndDrinkDownView.isHidden = index != 1
        transportDownView.isHidden = index != 2

        topAttrocitiesBackView.isHidden = index != 0
        eatAndDrinkBackView.isHidden = index != 1
        transportBackView.isHidden = index != 2
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDynamicHeights()
    }

//    func updateDynamicHeights() {
//        let guestReviewCount = isGuestReviewExpanded ? callGuestReview.count : min(callGuestReview.count, 3)
//        let guestReviewHeight = CGFloat(guestReviewCount) * 50
//        let guestWhoStayedHeight = CGFloat(callUserReview.count) * 100
//
//        guestReviewTVHightCons.constant = guestReviewHeight
//        GuestWhoStayedHereTVHeightCons.constant = guestWhoStayedHeight
//
//        let baseContentHeight: CGFloat = 2584 - 50 - 100
//        scrollViewContentViewHightCons.constant = baseContentHeight + guestReviewHeight + guestWhoStayedHeight
//
//       
//            view.layoutIfNeeded()
//        
//    }

    func updateDynamicHeights() {
        let guestReviewCount = isGuestReviewExpanded ? callGuestReview.count : min(callGuestReview.count, 3)
        let guestReviewHeight = CGFloat(guestReviewCount) * 50

        let maxUserReviewCount = min(callUserReview.count, 5)
        let guestWhoStayedHeight = CGFloat(maxUserReviewCount) * 100

        guestReviewTVHightCons.constant = guestReviewHeight
        GuestWhoStayedHereTVHeightCons.constant = guestWhoStayedHeight

        let baseContentHeight: CGFloat = 2164 - 50 - 100
        scrollViewContentViewHightCons.constant = baseContentHeight + guestReviewHeight + guestWhoStayedHeight

        view.layoutIfNeeded()
    }


    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y

       
        if offsetY > 100 {
            topNameLbl.text = hotelNameLBL.text
            topNameLbl.isHidden = false
        } else {
            topNameLbl.text = ""
            topNameLbl.isHidden = true
        }
    }
    func callData(){
        viewModel.loadJson { [weak self] success in
                DispatchQueue.main.async {
                    if success {
                        if let hotel = self?.viewModel.allHotels.first {
                            print("First hotel name: \(hotel.HotelName)")
                            self?.hotelNameLBL.text = hotel.HotelName
                            self?.aboutThisHotelDescP.text = hotel.Description
                            
                        }
                    } else {
                        print("Failed to load data.")
                    }
                }
            }
    }
    
    @IBAction func guestWhoStayedHereLovedViewAllButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserReviewsVC")as! UserReviewsVC
        vc.hotelName = hotelNameLBL.text
        present(vc, animated: true)
    }
    
    @IBAction func importantInformationReadMoreButton(_ sender: Any) {
    }
    @IBAction func attractionButton(_ sender: Any) {
        currentIndex = 0
            switchToCategory(index: currentIndex)
    }
    @IBAction func eatAndDrinkButton(_ sender: Any) {
        currentIndex = 1
            switchToCategory(index: currentIndex)
    }
    @IBAction func transportButton(_ sender: Any) {
        currentIndex = 2
            switchToCategory(index: currentIndex)
    }
    @IBAction func showMoreButton(_ sender: UIButton) {
        isGuestReviewExpanded.toggle()
        
        let newTitle = isGuestReviewExpanded ? "Show Less" : "Show More"
        let attributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 15)
        ]
        let attributedTitle = NSAttributedString(string: newTitle, attributes: attributes)
        sender.setAttributedTitle(attributedTitle, for: .normal)
        
        guestReviewTV.reloadData()
        updateDynamicHeights()
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func heartButton(_ sender: Any) {
    }
    
    @IBAction func shareButton(_ sender: Any) {
    }
    func locationWithPin(){
        let latitude: CLLocationDegrees = 13.0827
            let longitude: CLLocationDegrees = 80.2707

            let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)

            // Set region around the location
            let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapKitViewLatitudeLocation.setRegion(region, animated: true)

            // Add a pin
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Hotel Location" // Customize this title
            mapKitViewLatitudeLocation.addAnnotation(annotation)
    }
}

extension DetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hotelImagesCollectionView{
            return 1
        }else if collectionView == availabilitiesCollectionView{
            return callAvailabilities.count
        }else{
            return policies.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == hotelImagesCollectionView{
            let heightCons = hotelImagesCollectionView.frame.size.height - 10
            let widthCons = (hotelImagesCollectionView.frame.size.width - 10 )
            return CGSize(width: widthCons, height: heightCons)
        }else if collectionView == availabilitiesCollectionView{
            let heightCons = availabilitiesCollectionView.frame.size.height
            let widthCons = (availabilitiesCollectionView.frame.size.width - 10 ) / 3.8
            return CGSize(width: widthCons, height: heightCons)
        }else{
            let heightCons = policiesCollectionView.frame.size.height
            let widthCons = (policiesCollectionView.frame.size.width - 10 ) / 3
            return CGSize(width: widthCons, height: heightCons)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotelImagesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsPageHotelImagesCVC", for: indexPath)as! DetailsPageHotelImagesCVC
            
            cell.hotelImageOne.image = nil
            cell.hotelImageTwo.image = nil
            cell.hotelImageThree.image = nil
            cell.hotelImageFour.image = nil
            cell.hotelImageFive.image = nil
            cell.countLabel.isHidden = true
            
            
            if hotelImages.indices.contains(0) {
                cell.hotelImageOne.image = UIImage(named: hotelImages[0])
            }
            if hotelImages.indices.contains(1) {
                cell.hotelImageTwo.image = UIImage(named: hotelImages[1])
            }
            if hotelImages.indices.contains(2) {
                cell.hotelImageThree.image = UIImage(named: hotelImages[2])
            }
            if hotelImages.indices.contains(3) {
                cell.hotelImageFour.image = UIImage(named: hotelImages[3])
            }
            if hotelImages.indices.contains(4) {
                cell.hotelImageFive.image = UIImage(named: hotelImages[4])
                
                
                let remaining = hotelImages.count - 5
                if remaining > 0 {
                    cell.countLabel.isHidden = false
                    cell.countLabel.text = "+\(remaining)"
                }
            }
            
            return cell
        }else if collectionView == availabilitiesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AvailabilitiesCVC", for: indexPath)as! AvailabilitiesCVC
            let data = callAvailabilities[indexPath.row]
            cell.dataImage.image = UIImage(named: data.image)
            cell.titleLbl.text = data.name
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HotelPoliciesCVC", for: indexPath)as! HotelPoliciesCVC
            let data = policies[indexPath.row]
            cell.titleLbl.text = data
            return cell
        }
    }
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            if collectionView == hotelImagesCollectionView {
                
                let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
                let vc = storyboard.instantiateViewController(identifier: "ViewHotelImageVC")as! ViewHotelImageVC
                let titleValue = hotelNameLBL.text
                vc.images = hotelImages
                vc.titleData = titleValue
                present(vc, animated: true)
            }
        }
}

extension DetailsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == guestReviewTV{
            return isGuestReviewExpanded ? callGuestReview.count : min(callGuestReview.count, 3)
        }else{
            return callUserReview.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == guestReviewTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GuestReviewTVC")as! GuestReviewTVC
            let data = callGuestReview[indexPath.row]
            cell.titleLbl.text = data.name
            cell.countLbl.text = data.rating
            return cell
        }else{
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
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == guestReviewTV{
            return 50
        }else{
            return 100
        }
    }
}
