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
class DetailsViewController: UIViewController,UIScrollViewDelegate {
    
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
    
    let viewModel = HotelJsonViewModel()
    var callAvailabilities = [AvailabilitiesModel(name: "wellness", image: "wellness"),
                              AvailabilitiesModel(name: "dining", image: "dining"),
                              AvailabilitiesModel(name: "entertainment", image: "entertainment"),
                              AvailabilitiesModel(name: "business", image: "business")]
    var hotelImages = ["1","2","3","4","5","6","7","8","9","10","11"]
    var policies = ["Cancellation","Child","Comfort","Pet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hotelImagesCollectionView.register(UINib(nibName: "DetailsPageHotelImagesCVC", bundle: nil), forCellWithReuseIdentifier: "DetailsPageHotelImagesCVC")
        availabilitiesCollectionView.register(UINib(nibName: "AvailabilitiesCVC", bundle: nil), forCellWithReuseIdentifier: "AvailabilitiesCVC")
        policiesCollectionView.register(UINib(nibName: "HotelPoliciesCVC", bundle: nil), forCellWithReuseIdentifier: "HotelPoliciesCVC")
        noCreditCardNeededView.layer.cornerRadius = 10
        noCreditCardNeededView.layer.borderWidth = 2
        noCreditCardNeededView.layer.borderColor = UIColor.lightGray.cgColor
        
        summerOfferLbl.layer.cornerRadius = 5
        summerOfferLbl.clipsToBounds = true

        offerPercentageLbl.layer.cornerRadius = 5
        offerPercentageLbl.clipsToBounds = true

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
                vc.images = hotelImages
                present(vc, animated: true)
            }
        }

    
}
