//
//  DetailsViewController.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit
import MapKit


class DetailsViewController: UIViewController,UIScrollViewDelegate, MKMapViewDelegate {
    @IBOutlet weak var hotelAddressDataLbl: UILabel!
    @IBOutlet weak var hotelMailIdDataLbl: UILabel!
    @IBOutlet weak var hotelPhoneNumberDataLbl: UILabel!
    @IBOutlet weak var hotelWebSiteDataLbl: UILabel!
    @IBOutlet weak var tenPlusReviewCountLbl: UILabel!
    @IBOutlet weak var reviewContentTitleGoodLbl: UILabel!
    @IBOutlet weak var topBarView: UIView!
    @IBOutlet weak var transportTitleLbl: UILabel!
    @IBOutlet weak var eatAndDrinkTitleLbl: UILabel!
    @IBOutlet weak var TopAttreactionsTitleLbl: UILabel!
    @IBOutlet weak var eatAndDrinkTV: UITableView!
    @IBOutlet weak var publicTransportTV: UITableView!
    @IBOutlet weak var topAttractionsTV: UITableView!
    @IBOutlet weak var importantInformationtitle: UILabel!
    @IBOutlet weak var propertySurroundingTitle: UILabel!
    @IBOutlet weak var guestWhoStayedHereLovedTitle: UILabel!
    @IBOutlet weak var seeAllReviewsLbl: UILabel!
    @IBOutlet weak var seeAllCountLbbl: UILabel!
    @IBOutlet weak var seeAllLbl: UILabel!
    @IBOutlet weak var veryGoodLbl: UILabel!
    @IBOutlet weak var guestReviewTitle: UILabel!
    @IBOutlet weak var policiesTitle: UILabel!
    @IBOutlet weak var propertyLocationTitle: UILabel!
    @IBOutlet weak var roomsAndGuestsTitle: UILabel!
    @IBOutlet weak var checkOutTitle: UILabel!
    @IBOutlet weak var checkInTitle: UILabel!
    @IBOutlet weak var hotelAmeditiesTitl: UILabel!
    @IBOutlet weak var aboutThisHotelTitle: UILabel!
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
    var isHeartSelected = false
    var heartBarButton: UIBarButtonItem?
    var shareBarButton: UIBarButtonItem!
    var isGuestReviewExpanded = false
    var hotelDetailsData: Hotel?
    
    var filteredHotelImages: [HotelImage] {
        return viewModel.allhotelImages.filter { $0.hotelId == hotelDetailsData?.HotelId ?? ""}
    }
    let color = UIColor(named: "defaultColor")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CountryCodeManager.shared.fetchCountryCodes {
            DispatchQueue.main.async {
                self.GuestWhoStayedHereTV.reloadData()
            }
        }
        fontTextApply()
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
//        setupDefaultNavigationBarAppearance()
        scrollViewScroll.delegate = self
        
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
        
        topAttractionsTV.register(UINib(nibName: "TopAttractionTVC", bundle: nil), forCellReuseIdentifier: "TopAttractionTVC")
        eatAndDrinkTV.register(UINib(nibName: "TopAttractionTVC", bundle: nil), forCellReuseIdentifier: "TopAttractionTVC")
        publicTransportTV.register(UINib(nibName: "TopAttractionTVC", bundle: nil), forCellReuseIdentifier: "TopAttractionTVC")
        
        noCreditCardNeededView.layer.cornerRadius = 10
        noCreditCardNeededView.layer.borderWidth = 2
        noCreditCardNeededView.layer.borderColor = UIColor.lightGray.cgColor
        
        summerOfferLbl.layer.cornerRadius = 5
        summerOfferLbl.clipsToBounds = true
        
        offerPercentageLbl.layer.cornerRadius = 5
        offerPercentageLbl.clipsToBounds = true
        
        geniusDiscountLbl.layer.cornerRadius = 5
        geniusDiscountLbl.clipsToBounds = true
        
        callLandMarksData()
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
        labelActionGeture()
        
    }
    func labelActionGeture(){
        hotelMailIdDataLbl.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(mailLabelTapped))
        hotelMailIdDataLbl.addGestureRecognizer(tapGesture)
        
        hotelWebSiteDataLbl.isUserInteractionEnabled = true
        let websiteTap = UITapGestureRecognizer(target: self, action: #selector(websiteLabelTapped))
        hotelWebSiteDataLbl.addGestureRecognizer(websiteTap)
        
        hotelPhoneNumberDataLbl.isUserInteractionEnabled = true
        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(phoneLabelTapped))
        hotelPhoneNumberDataLbl.addGestureRecognizer(phoneTap)
    }
    func fontTextApply() {
        aboutThisHotelTitle.font = .poppinsBold(14)
        aboutThisHotelDescP.font = .poppinsMedium(12)
        hotelAmeditiesTitl.font = .poppinsBold(14)
        checkInTitle.font = .poppinsBold(12)
        checkOutTitle.font = .poppinsBold(12)
        checkInLbl.font = .poppinsMedium(12)
        checkOutLbl.font = .poppinsMedium(12)
        roomsAndGuestsTitle.font = .poppinsBold(14)
        roomsAndGuestLbl.font = .poppinsBold(12)
        priceForLbl.font = .poppinsMedium(12)
        offerPercentageLbl.font = .poppinsMedium(12)
        geniusDiscountLbl.font = .poppinsMedium(12)
        priceStrikeLbl.font = .poppinsMedium(12)
        actualPriceLbl.font = .poppinsBold(14)
        taxesAndChargesLbl.font = .poppinsMedium(10)
        propertyLocationTitle.font = .poppinsBold(14)
        propertySurroundingTitle.font = .poppinsBold(14)
        guestReviewTitle.font = .poppinsBold(14)
        veryGoodLbl.font = .poppinsMedium(12)
        seeAllLbl.font = .poppinsMedium(10)
        seeAllCountLbbl.font = .poppinsMedium(10)
        seeAllReviewsLbl.font = .poppinsMedium(10)
        guestWhoStayedHereLovedTitle.font = .poppinsBold(14)
        importantInformationtitle.font = .poppinsBold(14)
        policiesTitle.font = .poppinsBold(14)
        importantInformationLbl.font = .poppinsMedium(12)
        
        attractionButton.titleLabel?.font = .poppinsBold(12)
        eatAndDrinkButton.titleLabel?.font = .poppinsBold(12)
        transportButton.titleLabel?.font = .poppinsBold(12)
        
        buttonBoldText()
        TopAttreactionsTitleLbl.font = .poppinsBold(14)
        eatAndDrinkTitleLbl.font = .poppinsBold(14)
        transportTitleLbl.font = .poppinsBold(14)
        guestReviewRatingLbl.font = .poppinsMedium(12)
        hotelRatingLbl.font = .poppinsMedium(12)
        summerOfferLbl.font = .poppinsMedium(12)
        hotelNameLBL.font = .poppinsBold(20)
        tenPlusReviewCountLbl.font = .poppinsMedium(12)
        reviewContentTitleGoodLbl.font = .poppinsBold(14)
        
        hotelAddressDataLbl.font = .poppinsMedium(12)
        hotelMailIdDataLbl.font = .poppinsMedium(12)
        hotelPhoneNumberDataLbl.font = .poppinsMedium(12)
        hotelWebSiteDataLbl.font = .poppinsMedium(12)
        selectRoomButton.BackViewShadow()
    }
    
    @objc func mailLabelTapped() {
        guard let email = hotelMailIdDataLbl.text else { return }

        if let emailURL = URL(string: "mailto:\(email)") {
            if UIApplication.shared.canOpenURL(emailURL) {
                UIApplication.shared.open(emailURL)
            } else {
                print("⚠️ Cannot open mail app.")
            }
        }
    }
    
    @objc func websiteLabelTapped() {
        guard let urlString = hotelWebSiteDataLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let url = URL(string: urlString.starts(with: "http") ? urlString : "https://\(urlString)") else {
            print("Invalid website URL")
            return
        }

        UIApplication.shared.open(url)
    }
    
    @objc func phoneLabelTapped() {
        guard let number = hotelPhoneNumberDataLbl.text?.trimmingCharacters(in: .whitespacesAndNewlines),
              let phoneURL = URL(string: "tel://\(number)") else {
            print("Invalid phone number")
            return
        }

        if UIApplication.shared.canOpenURL(phoneURL) {
            UIApplication.shared.open(phoneURL)
        } else {
            print("Cannot make a call.")
        }
    }
    


    private func roundCornersOfGuestReviewRatingLabelContainer() {
        let maskPath = UIBezierPath(
            roundedRect: guestReviewRatingLbl.bounds,
            byRoundingCorners: [.topLeft, .topRight, .bottomRight],
            cornerRadii: CGSize(width: 8, height: 8)
        )

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        guestReviewRatingLbl.layer.mask = shape
    }
    private func roundCornersOfRatingLabelContainer() {
        let maskPath = UIBezierPath(
            roundedRect: hotelRatingLbl.bounds,
            byRoundingCorners: [.topLeft, .topRight, .bottomRight],
            cornerRadii: CGSize(width: 8, height: 8)
        )

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        hotelRatingLbl.layer.mask = shape
    }
    func buttonBoldText(){
        let selectRoom = NSAttributedString(
            string: "Select Room",
            attributes: [.font: UIFont.poppinsBold(14), .foregroundColor: UIColor.white]
        )
        selectRoomButton.setAttributedTitle(selectRoom, for: .normal)
        
        let readMoreInfo = NSAttributedString(
            string: "Read More",
            attributes: [.font: UIFont.poppinsBold(12), .foregroundColor: color ?? UIColor.blue]
        )
        importantInformationReadMoreButton.setAttributedTitle(readMoreInfo, for: .normal)
        
        let viewAll = NSAttributedString(
            string: "View All",
            attributes: [.font: UIFont.poppinsBold(12), .foregroundColor: color ?? UIColor.blue]
        )
        guestWhoStayedHereLovedViewAllButton.setAttributedTitle(viewAll, for: .normal)
        
        let readMore = NSAttributedString(
            string: "Show More",
            attributes: [.font: UIFont.poppinsBold(12), .foregroundColor: color ?? UIColor.blue]
        )
        showMoreButton.setAttributedTitle(readMore, for: .normal)
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
    func callLandMarksData(){
        viewModel.switchDisplayMode(to: .hotelNearbyLandmarks)
        
        viewModel.fetchHotels {
            DispatchQueue.main.async {
                self.topAttractionsTV.reloadData()
                self.eatAndDrinkTV.reloadData()
                self.publicTransportTV.reloadData()
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
                imageView?.isHidden = false
                imageView?.image = UIImage(named: "star")
            } else {
                imageView?.isHidden = true
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
    func navigationProcess() {
        heartBarButton = UIBarButtonItem(
            image: UIImage(named: "heart"),
            style: .plain,
            target: self,
            action: #selector(heartButtonTapped)
        )

        shareBarButton = UIBarButtonItem(
            image: UIImage(named: "share"),
            style: .plain,
            target: self,
            action: #selector(shareButtonTapped)
        )

        if let shareBarButton = shareBarButton, let heartBarButton = heartBarButton {
            navigationItem.rightBarButtonItems = [shareBarButton, heartBarButton]
        }

        navigationController?.navigationBar.tintColor = .white
    }

    @objc func heartButtonTapped() {
        isHeartSelected.toggle()
        
        let imageName = isHeartSelected ? "heartFill" : "heart"
        heartBarButton?.image = UIImage(named: imageName)
    }
    
    @objc func shareButtonTapped() {        
        let shareText = """
            Check out this hotel!
            
            Name: \(hotelDetailsData?.HotelName ?? "")
            Rating: \(hotelDetailsData?.StarRating ?? 0)
            Place: \(hotelDetailsData?.City ?? "")
            Location: \(hotelDetailsData?.Latitude ?? 0), \(hotelDetailsData?.Longitude ?? 0)
            """
        
        var activityItems: [Any] = [shareText]
        
        if let imageUrlString = filteredHotelImages.first?.imageUrl,
           let url = URL(string: imageUrlString),
           let data = try? Data(contentsOf: url),
           let image = UIImage(data: data) {
            activityItems.append(image)
        }
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        activityVC.popoverPresentationController?.barButtonItem = shareBarButton
        present(activityVC, animated: true, completion: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDynamicHeights()
        roundCornersOfRatingLabelContainer()
        roundCornersOfGuestReviewRatingLabelContainer()
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
        let rowHeight: CGFloat = 35
        let numberOfRows = ceil(CGFloat(policyCount.count) / itemsPerRow)
        let policiesHeight = numberOfRows * rowHeight

        policiesCollectionViewHeightCons.constant = policiesHeight

        let baseContentHeight: CGFloat = 2194 - 35 - 100
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

       
        if offsetY > 300 {
            topNameLbl.text = hotelNameLBL.text
            topNameLbl.isHidden = false
        } else {
            topNameLbl.text = ""
            topNameLbl.isHidden = true
        }
        let threshold: CGFloat = 15

        if offsetY > threshold {
           
            if let color = UIColor(named: "defaultColor") {
                topBarView.backgroundColor = color
                navigationController?.navigationBar.barTintColor = color
                navigationController?.navigationBar.backgroundColor = color
                navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
                navigationController?.navigationBar.tintColor = .white
            }
        } else {
            
//            setupDefaultNavigationBarAppearance()
        }
    }
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        setupDefaultNavigationBarAppearance()
//    }
    
//    func setupDefaultNavigationBarAppearance() {
//        if let color = UIColor(named: "backgroundColor") {
//            topBarView.backgroundColor = color
//            navigationController?.navigationBar.barTintColor = color
//            navigationController?.navigationBar.backgroundColor = color
//            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
//            navigationController?.navigationBar.tintColor = .black
//        }
//    }
    


    func callData(){
        hotelNameLBL.text = hotelDetailsData?.HotelName
        aboutThisHotelDescP.text = hotelDetailsData?.Description
    }
    
    @IBAction func selectRoomButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "RoomsListPageVC")as! RoomsListPageVC
        let titleValue = hotelDetailsData
        vc.hotelIdPass = titleValue
        vc.hotelDetailsData = hotelDetailsData
        navigationController?.pushViewController(vc, animated: true)
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
        let vc = storyboard.instantiateViewController(identifier: "UserFeedBackListVC")as! UserFeedBackListVC
        let backItem = UIBarButtonItem(title: "Your reviews", style: .plain, target: nil, action: nil)
        backItem.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
        navigationItem.backBarButtonItem = backItem
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func changeTextColorWhileSwipe(){
        if currentIndex == 0{
            attractionButton.tintColor = color
            eatAndDrinkButton.tintColor = .darkGray
            transportButton.tintColor = .darkGray
            attractionButton.setTitleColor(color, for: .normal)
            eatAndDrinkButton.setTitleColor(.darkGray, for: .normal)
            transportButton.setTitleColor(.darkGray, for: .normal)
        }else if currentIndex == 1{
            attractionButton.tintColor = .darkGray
            eatAndDrinkButton.tintColor = color
            transportButton.tintColor = .darkGray
            attractionButton.setTitleColor(.darkGray, for: .normal)
            eatAndDrinkButton.setTitleColor(color, for: .normal)
            transportButton.setTitleColor(.darkGray, for: .normal)
        }else if currentIndex == 2{
            attractionButton.tintColor = .darkGray
            eatAndDrinkButton.tintColor = .darkGray
            transportButton.tintColor = color
            attractionButton.setTitleColor(.darkGray, for: .normal)
            eatAndDrinkButton.setTitleColor(.darkGray, for: .normal)
            transportButton.setTitleColor(color, for: .normal)
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
            .font: UIFont(name: "Poppins-Bold", size: 12) ?? UIFont.boldSystemFont(ofSize: 12)
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
        } else if collectionView == availabilitiesCollectionView {
            return callAvailabilities.count
        } else {
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
            let font = UIFont.poppinsBold(12)
            let padding: CGFloat = 8
            
            let textWidth = (labelText as NSString).size(withAttributes: [.font: font]).width + padding * 2
            
            let availableWidth = collectionView.frame.width
            let interItemSpacing: CGFloat = 10
            let maxCellsPerRow: CGFloat = floor((availableWidth + interItemSpacing) / (textWidth + interItemSpacing))
            let finalCellWidth = (availableWidth - (maxCellsPerRow - 1) * interItemSpacing) / maxCellsPerRow
            
            let cellHeight = availabilitiesCollectionView.frame.size.height
            
            return CGSize(width: finalCellWidth, height: cellHeight)
        }else{
            let heightCons: CGFloat = 35
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
        }else if tableView == topAttractionsTV{
            let attractionsFilter = viewModel.allHotelNearbyLandmarks.filter({$0.hotelId == hotelDetailsData?.HotelId})
            let finalData = attractionsFilter.filter({$0.landmarkType == "Attractions"})
            return finalData.count
        }else if tableView == eatAndDrinkTV{
            let attractionsFilter = viewModel.allHotelNearbyLandmarks.filter({$0.hotelId == hotelDetailsData?.HotelId})
            let finalData = attractionsFilter.filter({$0.landmarkType == "Eat and Drink"})
            return finalData.count
        }else if tableView == publicTransportTV{
            let attractionsFilter = viewModel.allHotelNearbyLandmarks.filter({$0.hotelId == hotelDetailsData?.HotelId})
            let finalData = attractionsFilter.filter({$0.landmarkType == "Transport"})
            return finalData.count
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
        }else if tableView == topAttractionsTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopAttractionTVC")as! TopAttractionTVC
            let attractionsFilter = viewModel.allHotelNearbyLandmarks.filter({$0.hotelId == hotelDetailsData?.HotelId})
            let finalData = attractionsFilter.filter({$0.landmarkType == "Attractions"})
            let data = finalData[indexPath.row]
            cell.titleLbl.text = data.landmarkName
            cell.kmLbl.text = String(data.distanceInKm)
            return cell
        }else if tableView == eatAndDrinkTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopAttractionTVC")as! TopAttractionTVC
            let attractionsFilter = viewModel.allHotelNearbyLandmarks.filter({$0.hotelId == hotelDetailsData?.HotelId})
            let finalData = attractionsFilter.filter({$0.landmarkType == "Eat and Drink"})
            let data = finalData[indexPath.row]
            cell.titleLbl.text = data.landmarkName
            cell.kmLbl.text = String(data.distanceInKm)
            return cell
        }else if tableView == publicTransportTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "TopAttractionTVC")as! TopAttractionTVC
            let attractionsFilter = viewModel.allHotelNearbyLandmarks.filter({$0.hotelId == hotelDetailsData?.HotelId})
            let finalData = attractionsFilter.filter({$0.landmarkType == "Transport"})
            let data = finalData[indexPath.row]
            cell.titleLbl.text = data.landmarkName
            cell.kmLbl.text = String(data.distanceInKm)
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "GuestWhoStayedHereTVC") as! GuestWhoStayedHereTVC
            let data = callUserReview[indexPath.row]
            let matchData = countryViewModel.countries.filter({$0.name == data.country})
            
            print("Matched Data: \(matchData.first?.name ?? "")")
            let countryName = data.country.lowercased()
            if let countryCode = CountryCodeManager.shared.nameToCode[countryName] {
                let flagUrl = "https://flagsapi.com/\(countryCode.uppercased())/flat/64.png"
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
        }else if tableView == topAttractionsTV{
            return 30
        }else if tableView == eatAndDrinkTV{
            return 30
        }else if tableView == publicTransportTV{
            return 30
        }else{
            return 100
        }
    }
    func loadImage(from urlString: String, into imageView: UIImageView, completion: (() -> Void)? = nil) {
       
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
