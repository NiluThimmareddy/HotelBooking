//
//  DetailsViewController.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit
import MapKit


class DetailsViewController: UIViewController,UIScrollViewDelegate, MKMapViewDelegate {
    
    
    
    
    
    @IBOutlet weak var policiesCollectionViewHeightCons: NSLayoutConstraint!// default height 50
    @IBOutlet weak var selectRoomButton: UIButton!
    @IBOutlet weak var mapKitBackView: UIView!
    @IBOutlet weak var starFive: UIImageView!
    @IBOutlet weak var starFour: UIImageView!
    @IBOutlet weak var starThree: UIImageView!
    @IBOutlet weak var starTwo: UIImageView!
    @IBOutlet weak var starOne: UIImageView!
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
    @IBOutlet weak var viewMapButton: UIButton!
    
    let imageCache = NSCache<NSString, UIImage>()
    var currentIndex = 0
    let countryViewModel = CountryListViewModel()
    let viewModel = HotelJsonViewModel()
    var callAvailabilities = [AvailabilitiesModel(name: "Wellness", image: "wellness"),
                              AvailabilitiesModel(name: "Dining", image: "dining"),
                              AvailabilitiesModel(name: "Entertainment", image: "entertainment"),
                              AvailabilitiesModel(name: "Business", image: "business")]
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
    var hotelDetailsData: Hotel?
    
    var filteredHotelImages: [HotelImage] {
        return viewModel.allhotelImages.filter { $0.hotelId == hotelDetailsData?.HotelId ?? ""}
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CountryCodeManager.shared.fetchCountryCodes {
                DispatchQueue.main.async {
                    self.GuestWhoStayedHereTV.reloadData()
                }
            }
        navigationProcess()
        updateStarRating()
        hideViewAllButton()
        changeTextColorWhileSwipe()
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
        mapKitBackView.layer.cornerRadius = 10
        mapKitViewLatitudeLocation.layer.cornerRadius = 10
        mapKitViewLatitudeLocation.delegate = self
        topNameLbl.text = ""
        scrollViewScroll.delegate = self

        let originalPrice = "$ 280"
        let attributedString = NSAttributedString(
            string: originalPrice,
            attributes: [
                .strikethroughStyle: NSUnderlineStyle.single.rawValue,
                
            ]
        )

        priceStrikeLbl.attributedText = attributedString
        attractionButton.setTitleColor(currentIndex == 0 ? .systemBlue : .darkGray, for: .normal)
        eatAndDrinkButton.setTitleColor(currentIndex == 1 ? .systemBlue : .darkGray, for: .normal)
        transportButton.setTitleColor(currentIndex == 2 ? .systemBlue : .darkGray, for: .normal)

        navigationItem.titleView = topNameLbl
        callPoliciesData()
        callAllHotelsRoomData()
        callImagesData()
    }
    func callAllHotelsRoomData(){
        viewModel.switchDisplayMode(to: .hotelRooms)
        
        viewModel.fetchHotels {
            DispatchQueue.main.async {
                let filter = self.viewModel.allRooms.filter {
                    $0.hotelId == self.hotelDetailsData?.HotelId
                }
                print("HotelId: \(filter)")
                print("HotelId: \(filter)")
//                if let finalFilterData = filter.first {
//                    self.actualPriceLbl.text = "\(finalFilterData.basePrice)"
//                } else {
//                    self.actualPriceLbl.text = "N/A"
//                }
            }
        }
    }
    func callPoliciesData(){
        viewModel.switchDisplayMode(to: .policy)

        viewModel.fetchHotels {
            DispatchQueue.main.async {
                self.policiesCollectionView.reloadData()
                self.updateDynamicHeights()
            }
        }
    }
    func callImagesData(){
        viewModel.switchDisplayMode(to: .hotelImages)

        viewModel.fetchHotels {
            DispatchQueue.main.async {
                let filtered = self.filteredHotelImages
                print("Filter Images-----> \(filtered)")
                self.hotelImagesCollectionView.reloadData()
            }
        }
    }
    func updateStarRating() {
        let rating = Int(hotelDetailsData?.StarRating ?? 0)
        let starImageViews = [starOne, starTwo, starThree, starFour, starFive]
        for (index, imageView) in starImageViews.enumerated() {
            if index < rating {
                imageView?.image = UIImage(named: "star")
            } else {
                imageView?.image = UIImage(named: "star-2")
            }
        }
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
        changeTextColorWhileSwipe()
    }
    func navigationProcess(){
        let heartButton = UIBarButtonItem(
            image: UIImage(named: "heart"),
            style: .plain,
            target: self,
            action: #selector(heartButtonTapped)
        )
        
        
        let shareButton = UIBarButtonItem(
            image: UIImage(named: "share"),
            style: .plain,
            target: self,
            action: #selector(shareButtonTapped)
        )
       
        navigationItem.rightBarButtonItems = [shareButton, heartButton]
        navigationController?.navigationBar.tintColor = .white
    }
    @objc func heartButtonTapped() {
        print("❤️ Heart tapped")
        // Add favorite logic here
    }

    @objc func shareButtonTapped() {
        print("🔗 Share tapped")
        // Add share logic here
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDynamicHeights()
    }
    func updateDynamicHeights() {
        let guestReviewCount = isGuestReviewExpanded ? callGuestReview.count : min(callGuestReview.count, 3)
        let guestReviewHeight = CGFloat(guestReviewCount) * 50

        let maxUserReviewCount = min(callUserReview.count, 5)
        let guestWhoStayedHeight = CGFloat(maxUserReviewCount) * 100

        guestReviewTVHightCons.constant = guestReviewHeight
        GuestWhoStayedHereTVHeightCons.constant = guestWhoStayedHeight

        // Policies collection view height calculation
        let policyCount = self.viewModel.allPolicies.filter { $0.HotelId == self.hotelDetailsData?.HotelId }
        let itemsPerRow: CGFloat = 2
        let rowHeight: CGFloat = 50
        let numberOfRows = ceil(CGFloat(policyCount.count) / itemsPerRow)
        let policiesHeight = numberOfRows * rowHeight

        policiesCollectionViewHeightCons.constant = policiesHeight

        let baseContentHeight: CGFloat = 2154 - 50 - 100
        scrollViewContentViewHightCons.constant = baseContentHeight + guestReviewHeight + guestWhoStayedHeight + policiesHeight

        view.layoutIfNeeded()
    }

//    func updateDynamicHeights() {
//        let guestReviewCount = isGuestReviewExpanded ? callGuestReview.count : min(callGuestReview.count, 3)
//        let guestReviewHeight = CGFloat(guestReviewCount) * 50
//
//        let maxUserReviewCount = min(callUserReview.count, 5)
//        let guestWhoStayedHeight = CGFloat(maxUserReviewCount) * 100
//
//        guestReviewTVHightCons.constant = guestReviewHeight
//        GuestWhoStayedHereTVHeightCons.constant = guestWhoStayedHeight
//
//        let baseContentHeight: CGFloat = 2204 - 50 - 100 
//        scrollViewContentViewHightCons.constant = baseContentHeight + guestReviewHeight + guestWhoStayedHeight
//
//        view.layoutIfNeeded()
//    }


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
        hotelNameLBL.text = hotelDetailsData?.HotelName
        aboutThisHotelDescP.text = hotelDetailsData?.Description
    }
    
    @IBAction func selectRoomButtonAction(_ sender: Any) {
    }
    @IBAction func guestWhoStayedHereLovedViewAllButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserReviewsVC")as! UserReviewsVC
        vc.hotelName = hotelNameLBL.text
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func importantInformationReadMoreButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserFeedBack", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserFeedBackAfterCheckOutVC")as! UserFeedBackAfterCheckOutVC
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
    func changeTextColorWhileSwipe(){
        if currentIndex == 0{
            attractionButton.tintColor = .systemBlue
            eatAndDrinkButton.tintColor = .darkGray
            transportButton.tintColor = .darkGray
            attractionButton.setTitleColor(.systemBlue, for: .normal)
            eatAndDrinkButton.setTitleColor(.darkGray, for: .normal)
            transportButton.setTitleColor(.darkGray, for: .normal)
        }else if currentIndex == 1{
            attractionButton.tintColor = .darkGray
            eatAndDrinkButton.tintColor = .systemBlue
            transportButton.tintColor = .darkGray
            attractionButton.setTitleColor(.darkGray, for: .normal)
            eatAndDrinkButton.setTitleColor(.systemBlue, for: .normal)
            transportButton.setTitleColor(.darkGray, for: .normal)
        }else if currentIndex == 2{
            attractionButton.tintColor = .darkGray
            eatAndDrinkButton.tintColor = .darkGray
            transportButton.tintColor = .systemBlue
            attractionButton.setTitleColor(.darkGray, for: .normal)
            eatAndDrinkButton.setTitleColor(.darkGray, for: .normal)
            transportButton.setTitleColor(.systemBlue, for: .normal)
        }
    }
    @IBAction func attractionButton(_ sender: Any) {
        currentIndex = 0
        switchToCategory(index: currentIndex)
        changeTextColorWhileSwipe()
    }
    @IBAction func eatAndDrinkButton(_ sender: Any) {
        currentIndex = 1
        switchToCategory(index: currentIndex)
        changeTextColorWhileSwipe()
    }
    @IBAction func transportButton(_ sender: Any) {
        currentIndex = 2
        switchToCategory(index: currentIndex)
        changeTextColorWhileSwipe()
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
    
    @IBAction func viewMapButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "ViewHotelMapLocationVC")as! ViewHotelMapLocationVC
        vc.hotelDataPass = hotelDetailsData
        present(vc, animated: true)
    }
    @IBAction func heartButton(_ sender: Any) {
    }
    
    @IBAction func checkOutDateSelectButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CheckInCalendarVC")as! CheckInCalendarVC
        present(vc, animated: true)
    }
    @IBAction func checkIndateSelectButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CheckInCalendarVC")as! CheckInCalendarVC
        present(vc, animated: true)
    }
    @IBAction func guestCountTotalButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "GuestAndRoomsVC")as! GuestAndRoomsVC
        present(vc, animated: true)
    }
    @IBAction func shareButton(_ sender: Any) {
    }
    func locationWithPin() {
        let latitude: CLLocationDegrees = hotelDetailsData?.Latitude ?? 0
        let longitude: CLLocationDegrees = hotelDetailsData?.Longitude ?? 0

        let location = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let region = MKCoordinateRegion(center: location, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapKitViewLatitudeLocation.setRegion(region, animated: true)

        let annotation = MKPointAnnotation()
        annotation.coordinate = location
        annotation.title = hotelDetailsData?.HotelName
        mapKitViewLatitudeLocation.addAnnotation(annotation)
    }
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }

        let identifier = "CustomPin"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

        if annotationView == nil {
            annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
            annotationView?.image = UIImage(named: "mapPin") 
            annotationView?.frame.size = CGSize(width: 30, height: 30)
        } else {
            annotationView?.annotation = annotation
        }

        return annotationView
    }

}

extension DetailsViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hotelImagesCollectionView{
            return 1
        }else if collectionView == availabilitiesCollectionView{
            return callAvailabilities.count
        }else{
            let filter = self.viewModel.allPolicies.filter { $0.HotelId == self.hotelDetailsData?.HotelId }
            return filter.count
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == hotelImagesCollectionView{
            let heightCons = hotelImagesCollectionView.frame.size.height - 10
            let widthCons = (hotelImagesCollectionView.frame.size.width - 10 )
            return CGSize(width: widthCons, height: heightCons)
        }else if collectionView == availabilitiesCollectionView{
            let labelText = callAvailabilities[indexPath.row].name
            let font = UIFont.systemFont(ofSize: 12)
            let padding: CGFloat = 8
            
            let textWidth = (labelText as NSString).size(withAttributes: [.font: font]).width + padding * 2
            
            let availableWidth = collectionView.frame.width
            let interItemSpacing: CGFloat = 10
            let maxCellsPerRow: CGFloat = floor((availableWidth + interItemSpacing) / (textWidth + interItemSpacing))
            let finalCellWidth = (availableWidth - (maxCellsPerRow - 1) * interItemSpacing) / maxCellsPerRow
            
            let cellHeight = availabilitiesCollectionView.frame.size.height
            
            return CGSize(width: finalCellWidth, height: cellHeight)
        }else{
            let heightCons: CGFloat = 50
            let widthCons = (policiesCollectionView.frame.size.width - 10 ) / 2
            return CGSize(width: widthCons, height: heightCons)
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotelImagesCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailsPageHotelImagesCVC", for: indexPath)as! DetailsPageHotelImagesCVC
            
            let images = filteredHotelImages
            let startIndex = indexPath.row * 5
            let endIndex = min(startIndex + 5, images.count)
            let imagesToShow = Array(images[startIndex..<endIndex])
            
            let imageViews = [
                cell.hotelImageOne,
                cell.hotelImageTwo,
                cell.hotelImageThree,
                cell.hotelImageFour,
                cell.hotelImageFive
            ]
            
            
            for imageView in imageViews {
                imageView?.image = nil
                imageView?.stopShimmering()
            }
            
            cell.countLabel.isHidden = true
            cell.shadowView.isHidden = imagesToShow.count < 5
            cell.shadowViewButton.isHidden = imagesToShow.count < 5
            
            
            // Load images
            for (i, imageView) in imageViews.enumerated() {
                if i < imagesToShow.count {
                    let imageUrl = imagesToShow[i].imageUrl
                    
                    if let cachedImage = imageCache.object(forKey: imageUrl as NSString) {
                        imageView?.image = cachedImage
                        imageView?.stopShimmering()
                    } else {
                        imageView?.image = nil
                        imageView?.layoutIfNeeded()
                        imageView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
                        imageView?.startPulseShimmer()
                        
                        loadImage(from: imageUrl, into: imageView!) {
                            imageView?.stopShimmering()
                            imageView?.backgroundColor = .clear
                        }
                    }
                }
            }
            
            if imagesToShow.count == 5 {
                let remaining = images.count - (startIndex + 5)
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
            let filter = self.viewModel.allPolicies.filter { $0.HotelId == self.hotelDetailsData?.HotelId }
            let finalFilteredData = filter[indexPath.row]
            cell.titleLbl.text = finalFilteredData.PolicyType
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == hotelImagesCollectionView {
            
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "HotelImageOverViewVC")as! HotelImageOverViewVC
            let titleValue = hotelDetailsData
            vc.hotelIdPass = titleValue
            navigationItem.backButtonTitle = ""
            navigationController?.pushViewController(vc, animated: true)
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
    func loadImage(from urlString: String, into imageView: UIImageView, completion: (() -> Void)? = nil) {
        // Check cache first
        if let cachedImage = imageCache.object(forKey: urlString as NSString) {
            imageView.image = cachedImage
            completion?()
            return
        }
        
        guard let url = URL(string: urlString) else {
            imageView.image = UIImage(named: "placeholder")
            completion?()
            return
        }
        
        // Download image
        URLSession.shared.dataTask(with: url) { data, _, _ in
            DispatchQueue.main.async {
                if let data = data, let image = UIImage(data: data) {
                    self.imageCache.setObject(image, forKey: urlString as NSString)
                    imageView.image = image
                } else {
                    imageView.image = UIImage(named: "placeholder")
                }
                completion?()
            }
        }.resume()
    }
}
