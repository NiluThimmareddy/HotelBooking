//
//  HotelListPageVC.swift
//  HotelBooking
//
//  Created by toqsoft on 28/05/25.
//

import UIKit
import CoreLocation

class HotelListPageVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var hotelListTableview: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    
    let viewModel = HotelJsonViewModel()
    
    private let filterVC = FilterViewController()
    private let overlayView = UIView()
    
    var isClicked : Bool = false
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?
    var locationFetched = false
    var hotelsFetched = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @objc func overlayTapped() {
        isClicked = false
        hideFilters()
    }
    
    func showFilters() {
        filterVC.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        filterVC.view.alpha = 0
        overlayView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.overlayView.alpha = 1
            self.filterVC.view.alpha = 1
            self.filterVC.view.transform = .identity
        }
    }
    
    func hideFilters() {
        UIView.animate(withDuration: 0.3, animations: {
            self.filterVC.view.alpha = 0
            self.overlayView.alpha = 0
            self.filterVC.view.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let loc = locations.last else { return }
        currentLocation = loc
        locationFetched = true
        if hotelsFetched {
            hotelListTableview.reloadData()
        }
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func sortButtonAction(_ sender: Any) {
    }
    
    @IBAction func filterButtonAction(_ sender: Any) {
        isClicked.toggle()
        isClicked ? showFilters() : hideFilters()
    }
    
}

extension HotelListPageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.allHotels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HotelsListTVC", for: indexPath) as? HotelsListTVC else {
            return UITableViewCell()
        }
        
        let hotel = viewModel.allHotels[indexPath.row]
        let rooms = viewModel.allRooms.filter { $0.hotelId == hotel.HotelId }
        let cheapestRoom = rooms.min(by: { $0.basePrice < $1.basePrice })
        
        var distanceText = "10 km from the heart of the city"
        if let userLocation = currentLocation {
            let hotelLocation = CLLocation(latitude: hotel.Latitude, longitude: hotel.Longitude)
            let distanceInMeters = userLocation.distance(from: hotelLocation)
            let distanceInKm = distanceInMeters / 1000
            distanceText = String(format: "%.2f km", distanceInKm)
        } else {
            print("Location not ready when loading cell for \(hotel.HotelName)")
        }
        
        cell.configure(with: hotel, room: cheapestRoom, distance: distanceText)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 400
        } else {
            return 350
        }
    }
}

extension HotelListPageVC {
    func setUpUI() {
        hotelListTableview.delegate = self
        hotelListTableview.dataSource = self
        
        hotelListTableview.register(UINib(nibName: "HotelsListTVC", bundle: nil), forCellReuseIdentifier: "HotelsListTVC")

        viewModel.fetchHotels {
            self.hotelsFetched = true
            DispatchQueue.main.async {
                if self.locationFetched {
                    self.hotelListTableview.reloadData()
                }
            }
        }
        
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        overlayView.alpha = 0
        overlayView.frame = view.bounds
        overlayView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(overlayTapped)))
        view.addSubview(overlayView)
        
        addChild(filterVC)
        view.addSubview(filterVC.view)
        filterVC.didMove(toParent: self)
        
        let width = view.frame.width * 0.8
        let height = view.frame.height * 0.7
        filterVC.view.frame = CGRect(x: (view.frame.width - width) / 2,
                                     y: (view.frame.height - 450) / 2,
                                     width: width,
                                     height: height)
        filterVC.view.alpha = 0
        filterVC.view.layer.cornerRadius = 12
        filterVC.view.clipsToBounds = true
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}
