//
//  SearchBarViewController.swift
//  HotelBooking
//
//  Created by toqsoft on 18/06/25.
//

import UIKit
import MapKit
import CoreLocation

protocol SearchBarViewControllerDelegate: AnyObject {
    func didSelectSearchResult(_ result: String, withDateRange: String)
}

class SearchBarViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var arroundCurrentLocation: UIButton!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var continueSearchTableview: UITableView!
    
    var searchCompleter = MKLocalSearchCompleter()
    var suggestions: [MKLocalSearchCompletion] = []
    weak var delegate: SearchBarViewControllerDelegate?
    
    let locationManager = CLLocationManager()
    var currentPlacemark: CLPlacemark?
    var selectedDateRange: String? = Date.todayAndTomorrowFormattedRange()
    
    var searchHistory: [SearchHistoryItem] = [] {
        didSet {
            searchHistory = Array(searchHistory.prefix(5))
            saveSearchHistory()
            continueSearchTableview.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    @IBAction func arroundCurrentLoactionButtonAction(_ sender: Any) {
        if let placemark = currentPlacemark {
            let name = placemark.locality ?? placemark.administrativeArea ?? "Unknown"
            let newItem = SearchHistoryItem(destination: name, dateRange: selectedDateRange ?? Date.todayAndTomorrowFormattedRange())
            
            if !searchHistory.contains(where: { $0.destination == name }) {
                searchHistory.insert(newItem, at: 0)
                if searchHistory.count > 10 {
                    searchHistory.removeLast()
                }
            }
            
            delegate?.didSelectSearchResult(name, withDateRange: selectedDateRange ?? Date.todayAndTomorrowFormattedRange())
            navigationController?.popViewController(animated: true)
        } else {
            print("Current location not available yet.")
        }
    }
}

extension SearchBarViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == listTableView {
            return suggestions.count
        } else {
            return searchHistory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == listTableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableViewCell", for: indexPath) as? SearchListTableViewCell else {
                return UITableViewCell()
            }
            
            let suggestion = suggestions[indexPath.row]
            cell.nameLabel.text = "\(suggestion.title), \(suggestion.subtitle)"
            cell.imgView.image = UIImage(systemName: "mappin.and.ellipse")
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "ContinueSearchTVC", for: indexPath) as? ContinueSearchTVC else {
                return UITableViewCell()
            }
            
            let historyItem = searchHistory[indexPath.row]
            cell.searchedDestinationLabel.text = historyItem.destination
            cell.selectedDatesLabel.text = historyItem.dateRange
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == listTableView {
            let selectedSuggestion = suggestions[indexPath.row]
            let selectedText = "\(selectedSuggestion.title), \(selectedSuggestion.subtitle)"
            searchBar.text = selectedSuggestion.title
            currentLocationLabel.text = selectedText

            let selectedDate = selectedDateRange ?? "No Dates Selected"
            print("🔍 Saving search for \(selectedText) with date: \(selectedDate)")

            let newItem = SearchHistoryItem(destination: selectedText, dateRange: selectedDate)

            if let index = searchHistory.firstIndex(where: { $0.destination == selectedText }) {
                searchHistory.remove(at: index)
            }

            searchHistory.insert(newItem, at: 0)
            searchHistory = Array(searchHistory.prefix(5))

            delegate?.didSelectSearchResult(selectedText, withDateRange: selectedDate)
            suggestions.removeAll()
            listTableView.reloadData()
            listTableView.isHidden = true
            searchBar.resignFirstResponder()
            navigationController?.popViewController(animated: true)
        } else {
            let selectedItem = searchHistory[indexPath.row]
            delegate?.didSelectSearchResult(selectedItem.destination, withDateRange: selectedItem.dateRange)
            navigationController?.popViewController(animated: true)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SearchBarViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            suggestions.removeAll()
            listTableView.reloadData()
            listTableView.isHidden = true
            return
        }
        
        searchCompleter.queryFragment = searchText
        listTableView.isHidden = false
    }
}

extension SearchBarViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        suggestions = completer.results
        listTableView.reloadData()
        listTableView.isHidden = suggestions.isEmpty
    }

}

extension SearchBarViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first {
                self.currentPlacemark = placemark
                let name = placemark.locality ?? placemark.administrativeArea ?? "Unknown"
                self.currentLocationLabel.text = name
            }
        }
        locationManager.stopUpdatingLocation()
    }
}

extension SearchBarViewController {
    func setUpUI() {
        listTableView.register(UINib(nibName: "SearchListTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchListTableViewCell")
        continueSearchTableview.register(UINib(nibName: "ContinueSearchTVC", bundle: nil), forCellReuseIdentifier: "ContinueSearchTVC")
        
        searchBar.delegate = self
        searchCompleter.delegate = self
        searchCompleter.resultTypes = [.address, .pointOfInterest]
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        listTableView.isHidden = true
        
        loadSearchHistory()
    }
    
    func saveSearchHistory() {
        if let encoded = try? JSONEncoder().encode(searchHistory) {
            UserDefaults.standard.set(encoded, forKey: "SearchHistory")
        }
    }
    
    func loadSearchHistory() {
        if let data = UserDefaults.standard.data(forKey: "SearchHistory"),
           let decoded = try? JSONDecoder().decode([SearchHistoryItem].self, from: data) {
            searchHistory = decoded
        }
    }
}

