//
//  SortFilterViewController.swift
//  HotelBooking
//
//  Created by toqsoft on 11/06/25.
//
/*
import UIKit

class SortFilterViewController: UIViewController {

    @IBOutlet weak var sortFilterTableView: UITableView!
    
    var sortOptions = ["Entire homes & apartments first","Distance from city center","our top picks","Property rating (high to low)","Property rating (low to high)","Genius","Guest review score","Price(low to high)","Savedproperties first"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortFilterTableView.register(UINib(nibName: "SortFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "SortFilterTableViewCell")
    }

}

extension SortFilterViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortOptions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SortFilterTableViewCell") as! SortFilterTableViewCell
        let sort = sortOptions[indexPath.row]
        cell.contentLabel.text = sort
        return cell
    }
}

*/

import UIKit

class SortFilterViewController: UIViewController {

    @IBOutlet weak var sortFilterTableView: UITableView!
    
    var sortOptions = ["Entire homes & apartments first","Distance from city center","our top picks","Property rating (high to low)","Property rating (low to high)","Genius","Guest review score","Price (low to high)","Saved properties first"]
    
    var selectedIndex: Int?
    let selectedColor = UIColor(hex: "#003B95")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sortFilterTableView.register(UINib(nibName: "SortFilterTableViewCell", bundle: nil), forCellReuseIdentifier: "SortFilterTableViewCell")
        sortFilterTableView.tableFooterView = UIView()
//        setDefaultSelection()
    }
    private func setDefaultSelection() {
        selectedIndex = sortOptions.count - 1
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
            self?.handleSelection(at: indexPath)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        handleSelection(at: indexPath)
    }
    
    private func handleSelection(at indexPath: IndexPath) {
        selectedIndex = indexPath.row
        sortFilterTableView.reloadData()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            self.navigateToHotelList(with: self.sortOptions[indexPath.row])
        }
    }
    
    private func navigateToHotelList(with sortOption: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        guard let hotelListVC = storyboard.instantiateViewController(withIdentifier: "HotelListPageVC") as? HotelListPageVC else {
            print("Error: Failed to instantiate HotelListPageVC")
            return
        }
        
        hotelListVC.selectedSortOption = sortOption
        
        if let navController = navigationController {
            navController.pushViewController(hotelListVC, animated: true)
        } else {
            present(hotelListVC, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let lastIndex = selectedIndex {
            let indexPath = IndexPath(row: lastIndex, section: 0)
            sortFilterTableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        }
    }
}
