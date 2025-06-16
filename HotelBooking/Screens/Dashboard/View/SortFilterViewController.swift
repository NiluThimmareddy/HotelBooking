//
//  SortFilterViewController.swift
//  HotelBooking
//
//  Created by toqsoft on 11/06/25.
//

import UIKit

protocol SortFilterDelegate: AnyObject {
    func didSelectSortOption(_ option: String)
}

class SortFilterViewController: UIViewController {

    @IBOutlet weak var sortFilterTableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var sortOptions = ["Entire homes & apartments first","Distance from city center","our top picks","Property rating (high to low)","Property rating (low to high)","Genius","Guest review score","Price (low to high)","Price (high to low)","Saved properties first"]
    
    weak var delegate: SortFilterDelegate?
    
    var selectedIndex: Int?
    let selectedColor = UIColor(hex: "#003B95")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortFilterTableView.register(UINib(nibName: "SortFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "SortFilterTableViewCell")
    }

    @IBAction func addButtonAction(_ sender: Any) {
        guard let selectedIndex = selectedIndex else { return }
        let selectedOption = sortOptions[selectedIndex]
        delegate?.didSelectSortOption(selectedOption)
        dismiss(animated: true)
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: "No Option Selected", message: "Please select a sort option before proceeding.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
  }

extension SortFilterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortFilterTableViewCell", for: indexPath) as! SortFilterTableViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    private func configureCell(_ cell: SortFilterTableViewCell, at indexPath: IndexPath) {
        let sortOption = sortOptions[indexPath.row]
        cell.contentLabel.text = sortOption
        
        let isSelected = selectedIndex == indexPath.row
        let imageName = isSelected ? "record.circle.fill" : "circle"
        cell.selectButton.setImage(UIImage(systemName: imageName), for: .normal)
        cell.selectButton.tintColor = isSelected ? selectedColor : .systemGray
        
        cell.buttonAction = { [weak self] in
            self?.selectedIndex = indexPath.row
            self?.sortFilterTableView.reloadData()
        }
    }
}

extension HotelListPageVC: SortFilterDelegate {
    func didSelectSortOption(_ option: String) {
        selectedSortOption = option
        applySorting()
    }
    func applySorting() {
        guard let sortOption = selectedSortOption else { return }
        
        switch sortOption {
            
        case "Entire homes & apartments first":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                let isHome1 = hotel1.HotelType.lowercased().contains("entire") || hotel1.HotelType.lowercased().contains("apartment")
                let isHome2 = hotel2.HotelType.lowercased().contains("entire") || hotel2.HotelType.lowercased().contains("apartment")
                return (isHome1 ? 0 : 1) < (isHome2 ? 0 : 1)
            }
            
        case "Distance from city center":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                let distance1 = viewModel.allHotelNearbyLandmarks.first(where: { $0.hotelId == hotel1.HotelId })?.distanceInKm ?? Double.greatestFiniteMagnitude
                let distance2 = viewModel.allHotelNearbyLandmarks.first(where: { $0.hotelId == hotel2.HotelId })?.distanceInKm ?? Double.greatestFiniteMagnitude
                return distance1 < distance2
            }
            
        case "our top picks":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                let score1 = (hotel1.StarRating ?? 0)
                let score2 = (hotel2.StarRating ?? 0)
                return score1 > score2
            }
            
        case "Property rating (high to low)":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                (hotel1.StarRating ?? 0) > (hotel2.StarRating ?? 0)
            }
            
        case "Property rating (low to high)":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                (hotel1.StarRating ?? 0) < (hotel2.StarRating ?? 0)
            }
            
        case "Genius":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                let isGenius1 = hotel1.HotelChain.lowercased().contains("genius") || hotel1.Email.lowercased().contains("genius")
                let isGenius2 = hotel2.HotelChain.lowercased().contains("genius") || hotel2.Email.lowercased().contains("genius")
                return (isGenius1 ? 0 : 1) < (isGenius2 ? 0 : 1)
            }
            
        case "Guest review score":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                (hotel1.reviewScore ?? 0) > (hotel2.reviewScore ?? 0)
            }
            
        case "Price (low to high)":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                let room1 = viewModel.allRooms.filter { $0.hotelId == hotel1.HotelId }.min(by: { $0.basePrice < $1.basePrice })
                let room2 = viewModel.allRooms.filter { $0.hotelId == hotel2.HotelId }.min(by: { $0.basePrice < $1.basePrice })
                let price1 = room1?.basePrice ?? Double.greatestFiniteMagnitude
                let price2 = room2?.basePrice ?? Double.greatestFiniteMagnitude
                return price1 < price2
            }
            
        case "Price (high to low)":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                let room1 = viewModel.allRooms.filter { $0.hotelId == hotel1.HotelId }.min(by: { $0.basePrice < $1.basePrice })
                let room2 = viewModel.allRooms.filter { $0.hotelId == hotel2.HotelId }.min(by: { $0.basePrice < $1.basePrice })
                let price1 = room1?.basePrice ?? 0
                let price2 = room2?.basePrice ?? 0
                return price1 > price2
            }
            
        case "Saved properties first":
            viewModel.allHotels.sort { (hotel1: Hotel, hotel2: Hotel) in
                let isSaved1 = viewModel.savedHotelIds.contains(hotel1.HotelId)
                let isSaved2 = viewModel.savedHotelIds.contains(hotel2.HotelId)
                return (isSaved1 ? 0 : 1) < (isSaved2 ? 0 : 1)
            }
            
        default:
            break
        }
        
        hotelListTableview.reloadData()
    }

}
