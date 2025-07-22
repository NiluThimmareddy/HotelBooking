//
//  ViewHotelMapLocationVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 05/06/25.
//

import UIKit
import MapKit
import CoreLocation

class HotelAnnotation: MKPointAnnotation {
    var hotelName: String?
}

class ViewHotelMapLocationVC: UIViewController, MKMapViewDelegate, UITextFieldDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var moreMenuButtonTV: UITableView!
    @IBOutlet weak var moreMenuButton: UIButton!
    @IBOutlet weak var shimmerEffectView: UIView!
    @IBOutlet weak var hotelDetailsUpdatedPopUpLbl: UILabel!
    @IBOutlet weak var hotelDetailsUpdatedPopUpView: UIView!
    @IBOutlet weak var searchBarBackView: UIView!
    @IBOutlet weak var satelliteImageBackView: UIView!
    @IBOutlet weak var defaultImageBackView: UIView!
    @IBOutlet weak var satelliteImage: UIImageView!
    @IBOutlet weak var defaultImage: UIImageView!
    @IBOutlet weak var mapTypeBackView: UIView!
    @IBOutlet weak var mapTypeCloseButtonView: UIView!
    @IBOutlet weak var mapTypeCloseButton: UIButton!
    @IBOutlet weak var selectRoomButton: UIButton!
    @IBOutlet weak var taxAndCharges: UILabel!
    @IBOutlet weak var newPrice: UILabel!
    @IBOutlet weak var oldPrice: UILabel!
    @IBOutlet weak var priceForTwoNights: UILabel!
    @IBOutlet weak var hotelOffersName: UILabel!
    @IBOutlet weak var hotelOffersPercentage: UILabel!
    @IBOutlet weak var hotelTotalReview: UILabel!
    @IBOutlet weak var hotelRatingTitle: UILabel!
    @IBOutlet weak var hotelRating: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelImage: UIImageView!
    @IBOutlet weak var searchLocationTextField: UITextField!
    @IBOutlet weak var locatorButton: UIButton!
    @IBOutlet weak var mapTypeButton: UIButton!
    @IBOutlet weak var smallBackView: UIView!
    @IBOutlet weak var mapDataView: MKMapView!
    
    let locationManager = CLLocationManager()
    let viewModel = HotelJsonViewModel()
    var hotelDataPass: Hotel?
    let color = UIColor(named: "defaultColor")
    var selectedName: String?
    var moreButtonTvData = ["Copy Address","Copy GPS Co-ordinates","Open in Google Maps"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        callHotelData()
        moreMenuButtonTV.isHidden = true
        moreMenuButtonTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        let image = UIImage(systemName: "ellipsis")?.withRenderingMode(.alwaysTemplate)
        moreMenuButton.setImage(image, for: .normal)
        moreMenuButton.tintColor = .black
        moreMenuButton.transform = CGAffineTransform(rotationAngle: .pi / 2)
        mapDataView.delegate = self
        searchLocationTextField.delegate = self
        mapTypeButton.layer.cornerRadius = mapTypeButton.frame.height / 2
        locatorButton.layer.cornerRadius = locatorButton.frame.size.height / 2
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        mapDataView.showsUserLocation = true
        
        hotelName.text = hotelDataPass?.HotelName
        
        mapViewHidden()
        mapTypeBackView.applyCardStyle()
        mapTypeBackView.layer.cornerRadius = 15
        
        buttonHightLight()
        defaultImageBackView.layer.cornerRadius = 5
        satelliteImageBackView.layer.cornerRadius = 5
        searchBarBackView.layer.cornerRadius = 10
        searchBarBackView.layer.borderWidth = 2
        searchBarBackView.layer.borderColor = color?.cgColor
        
        hotelDetailsUpdatedPopUpView.isHidden = true
        hotelDetailsUpdatedPopUpView.layer.cornerRadius = 8
        hotelDetailsUpdatedPopUpView.layer.shadowColor = UIColor.black.cgColor
        hotelDetailsUpdatedPopUpView.layer.shadowOpacity = 0.2
        hotelDetailsUpdatedPopUpView.layer.shadowOffset = CGSize(width: 0, height: 2)
        shimmerEffectView.isHidden = true
        shimmerEffectView.alpha = 0.6

    }
    
    func showHotelUpdatedPopup(with name: String) {
        hotelDetailsUpdatedPopUpLbl.text = "\(name) Details Updated"
        
        let screenWidth = UIScreen.main.bounds.width
        hotelDetailsUpdatedPopUpView.transform = CGAffineTransform(translationX: -screenWidth, y: 0)
        hotelDetailsUpdatedPopUpView.alpha = 1
        hotelDetailsUpdatedPopUpView.isHidden = false

        UIView.animate(withDuration: 0.5, animations: {
            self.hotelDetailsUpdatedPopUpView.transform = .identity
        }) { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                UIView.animate(withDuration: 0.5, animations: {
                    self.hotelDetailsUpdatedPopUpView.transform = CGAffineTransform(translationX: screenWidth, y: 0)
                    self.hotelDetailsUpdatedPopUpView.alpha = 0
                }) { _ in
                    self.hotelDetailsUpdatedPopUpView.isHidden = true
                }
            }
        }
    }



    func mapViewHidden(){
        mapTypeCloseButton.isHidden = true
        mapTypeCloseButtonView.isHidden = true
        mapTypeBackView.isHidden = true
        
    }
    func loadHotelRoomsManually(completion: @escaping () -> Void) {
        guard let path = Bundle.main.path(forResource: "HotelJsonData", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Could not load HotelJsonData.json")
            completion()
            return
        }

        do {
            let decoded = try JSONDecoder().decode(HotelJsonRoot.self, from: data)
            self.viewModel.allRooms = decoded.HotelRooms ?? []
            print("✅ Rooms Loaded: \(self.viewModel.allRooms.count)")
            completion()
        } catch {
            print("❌ Failed to decode HotelRooms: \(error)")
            completion()
        }
    }

    func callHotelData() {
            viewModel.switchDisplayMode(to: .hotelRooms)
            viewModel.switchDisplayMode(to: .hotelImages)
            loadHotelRoomsManually {
                self.viewModel.switchDisplayMode(to: .hotel)

                self.viewModel.fetchHotels {
                    DispatchQueue.main.async {
                        self.mapDataView.removeAnnotations(self.mapDataView.annotations)

                        guard let selectedHotel = self.hotelDataPass else { return }

                        let hotelsInCity = self.viewModel.allHotels.filter { $0.City == selectedHotel.City }
                        
                        for hotel in hotelsInCity {
                            let coordinate = CLLocationCoordinate2D(latitude: hotel.Latitude, longitude: hotel.Longitude)
                            
                            let annotation = HotelAnnotation()
                            annotation.coordinate = coordinate
                            annotation.hotelName = hotel.HotelName
                            let hotelsImages = self.viewModel.allhotelImages.filter { $0.hotelId == hotel.HotelId  }
                            
                            if let room = self.viewModel.allRooms.first(where: { $0.hotelId == hotel.HotelId }) {
                                annotation.title = "$\(room.basePrice)"
                            } else {
                                annotation.title = hotel.HotelName
                            }

                            self.mapDataView.addAnnotation(annotation)
                        }

                        let selectedCoordinate = CLLocationCoordinate2D(latitude: selectedHotel.Latitude, longitude: selectedHotel.Longitude)
                        let region = MKCoordinateRegion(center: selectedCoordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                        self.mapDataView.setRegion(region, animated: true)
                    }
                }
            }
        }

    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation {
            return nil
        }
        
        if let selectedHotel = hotelDataPass,
           annotation.coordinate.latitude == selectedHotel.Latitude,
           annotation.coordinate.longitude == selectedHotel.Longitude {

            let identifier = "SelectedHotel"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false
                annotationView?.image = UIImage(named: "mapPin")
                annotationView?.frame.size = CGSize(width: 30, height: 30)
            } else {
                annotationView?.annotation = annotation
            }

            return annotationView

        } else {
            let identifier = "ChatBubbleAnnotation"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier)

            if annotationView == nil {
                annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView?.canShowCallout = false

                let bubbleWidth: CGFloat = 80
                let bubbleHeight: CGFloat = 25
                let tailHeight: CGFloat = 10

                let bubbleView = UIView(frame: CGRect(x: 0, y: 0, width: bubbleWidth, height: bubbleHeight + tailHeight))
                bubbleView.tag = 3001
                bubbleView.backgroundColor = .clear

                let shapeLayer = CAShapeLayer()
                let path = UIBezierPath()

                path.move(to: CGPoint(x: 10, y: 0))
                path.addLine(to: CGPoint(x: bubbleWidth - 10, y: 0))
                path.addQuadCurve(to: CGPoint(x: bubbleWidth, y: 10), controlPoint: CGPoint(x: bubbleWidth, y: 0))
                path.addLine(to: CGPoint(x: bubbleWidth, y: bubbleHeight - 10))
                path.addQuadCurve(to: CGPoint(x: bubbleWidth - 10, y: bubbleHeight), controlPoint: CGPoint(x: bubbleWidth, y: bubbleHeight))
                
                path.addLine(to: CGPoint(x: bubbleWidth / 2 + 5, y: bubbleHeight))
                path.addLine(to: CGPoint(x: bubbleWidth / 2, y: bubbleHeight + tailHeight))
                path.addLine(to: CGPoint(x: bubbleWidth / 2 - 5, y: bubbleHeight))

                path.addLine(to: CGPoint(x: 10, y: bubbleHeight))
                path.addQuadCurve(to: CGPoint(x: 0, y: bubbleHeight - 10), controlPoint: CGPoint(x: 0, y: bubbleHeight))
                path.addLine(to: CGPoint(x: 0, y: 10))
                path.addQuadCurve(to: CGPoint(x: 10, y: 0), controlPoint: CGPoint(x: 0, y: 0))
                path.close()

                shapeLayer.path = path.cgPath
                shapeLayer.fillColor = UIColor(red: 0/255, green: 59/255, blue: 149/255, alpha: 1).cgColor
                bubbleView.layer.insertSublayer(shapeLayer, at: 0)

                let label = UILabel(frame: CGRect(x: 8, y: 5, width: bubbleWidth - 16, height: bubbleHeight - 10))
                label.tag = 1001
                label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
                label.textColor = .white
                label.textAlignment = .center
                label.numberOfLines = 2
                bubbleView.addSubview(label)

                annotationView?.addSubview(bubbleView)
                annotationView?.frame = bubbleView.frame
                annotationView?.centerOffset = CGPoint(x: 0, y: -(bubbleHeight + tailHeight) / 2)
            } else {
                annotationView?.annotation = annotation
            }

            if let bubbleView = annotationView?.viewWithTag(3001),
               let label = bubbleView.viewWithTag(1001) as? UILabel {
                label.text = annotation.title ?? ""
            }

            return annotationView
        }
    }





    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        guard let annotation = view.annotation as? HotelAnnotation else { return }
        

        shimmerEffectView.isHidden = false
        shimmerEffectView.startPulseShimmerr()
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.shimmerEffectView.stopShimmering()
            self.shimmerEffectView.isHidden = true
            
            let hotelNameText = annotation.hotelName ?? "Unknown Hotel"
            self.hotelName.text = hotelNameText
            self.showHotelUpdatedPopup(with: hotelNameText)
            
            let fil = self.viewModel.allHotels.filter { $0.HotelName == hotelNameText }
            let hotelId = self.viewModel.allhotelImages.filter { $0.hotelId == fil.first?.HotelId }
            let hotelUrl = hotelId.first?.imageUrl
            print("Hotel Url: \(hotelUrl ?? "")")
            
            if let url = URL(string: hotelUrl ?? "") {
                DispatchQueue.global().async {
                    if let data = try? Data(contentsOf: url),
                       let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.hotelImage.image = image
                        }
                    } else {
                        DispatchQueue.main.async {
                            self.hotelImage.image = UIImage(systemName: "photo")
                        }
                    }
                }
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        guard let searchText = textField.text, !searchText.isEmpty else {
            return false
        }
        
        performSearch(for: searchText)
        
        return true
    }
    
    func performSearch(for query: String) {
        let cityFilteredHotels = viewModel.allHotels.filter { $0.City == hotelDataPass?.City }

        if let matchedHotel = cityFilteredHotels.first(where: { $0.HotelName.range(of: query, options: .caseInsensitive) != nil }) {

            let coordinate = CLLocationCoordinate2D(latitude: matchedHotel.Latitude, longitude: matchedHotel.Longitude)
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapDataView.setRegion(region, animated: true)
            print("Found hotel: \(matchedHotel.HotelName)")
        } else {
            // 2. If no hotel found, do MKLocalSearch for location
            let request = MKLocalSearch.Request()
            request.naturalLanguageQuery = query
            
            let search = MKLocalSearch(request: request)
            search.start { [weak self] response, error in
                guard let self = self else { return }
                if let coordinate = response?.mapItems.first?.placemark.coordinate {
                    let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
                    self.mapDataView.setRegion(region, animated: true)
                    print("Found location: \(query)")
                } else {
                    print("Location not found")
                   
                }
            }
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // Optional: you can use this if you want real-time tracking
        guard let location = locations.last else { return }
    }
    
    func buttonHightLight(){
        if mapDataView.mapType == .hybrid{
            satelliteImageBackView.layer.borderWidth = 2
            satelliteImageBackView.layer.borderColor = color?.cgColor
            defaultImageBackView.layer.borderWidth = 0
            defaultImageBackView.layer.borderColor = color?.cgColor
        }else{
            defaultImageBackView.layer.borderWidth = 2
            defaultImageBackView.layer.borderColor = color?.cgColor
            satelliteImageBackView.layer.borderWidth = 0
            satelliteImageBackView.layer.borderColor = color?.cgColor
        }
    }
    @IBAction func satelliteViewButton(_ sender: Any) {
        mapDataView.mapType = .hybrid
        buttonHightLight()
    }
    @IBAction func defaultViewButton(_ sender: Any) {
        mapDataView.mapType = .standard
        buttonHightLight()
    }
    @IBAction func mapTypeCloseButton(_ sender: Any) {
        mapViewHidden()
        buttonHightLight()
    }
    @IBAction func selectRoomButton(_ sender: Any) {
    }
    @IBAction func locatorButton(_ sender: Any) {
        if let userLocation = locationManager.location?.coordinate {
            let region = MKCoordinateRegion(center: userLocation, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapDataView.setRegion(region, animated: true)
        } else {
            print("⚠️ Unable to get current location.")
        }
    }
    @IBAction func mapTypeButton(_ sender: Any) {
        mapTypeCloseButton.isHidden = false
        mapTypeCloseButtonView.isHidden = false
        mapTypeBackView.isHidden = false
    }
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func menuButton(_ sender: Any) {
        moreMenuButtonTV.isHidden = !moreMenuButtonTV.isHidden
    }
    
}


extension ViewHotelMapLocationVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreButtonTvData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFeedBackAfterCheckOutTVC")as! UserFeedBackAfterCheckOutTVC
        cell.titleData.text = moreButtonTvData[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let hotel = hotelDataPass else { return }

            switch indexPath.row {
            case 0:
                // Copy Address
                UIPasteboard.general.string = hotel.AddressLine1
                showToast(message: "Address copied!")

            case 1:
                // Copy GPS Coordinates
                let coordinates = "\(hotel.Latitude), \(hotel.Longitude)"
                UIPasteboard.general.string = coordinates
                showToast(message: "Coordinates copied!")

            case 2:
                // Open in Google Maps
                let urlString = "comgooglemaps://?q=\(hotel.Latitude),\(hotel.Longitude)"
                if let url = URL(string: urlString), UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                } else {
                    // Fallback to browser
                    let webUrl = "https://maps.google.com/?q=\(hotel.Latitude),\(hotel.Longitude)"
                    if let url = URL(string: webUrl) {
                        UIApplication.shared.open(url)
                    }
                }

            default:
                break
            }

            tableView.deselectRow(at: indexPath, animated: true)
        }
    
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textAlignment = .center
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textColor = .white
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.alpha = 0.0
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true

        if let window = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let labelWidth = window.frame.width - 40
            toastLabel.frame = CGRect(x: 20, y: window.frame.height - 120, width: labelWidth, height: 40)
            window.addSubview(toastLabel)

            UIView.animate(withDuration: 0.5, animations: {
                toastLabel.alpha = 1.0
            }) { _ in
                UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                    toastLabel.alpha = 0.0
                }) { _ in
                    toastLabel.removeFromSuperview()
                }
            }
        }
    }

}
