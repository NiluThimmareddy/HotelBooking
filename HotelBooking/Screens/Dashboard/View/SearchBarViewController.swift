//
//  SearchBarViewController.swift
//  HotelBooking
//
//  Created by toqsoft on 18/06/25.
//

/*
import UIKit

class SearchBarViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var arroundCurrentLocation: UIButton!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(UINib(nibName: "SearchListTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchListTableViewCell")
    }

    @IBAction func arroundCurrentLoactionButtonAction(_ sender: Any) {
    }
    
}
*/

import UIKit
import MapKit

class SearchBarViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var arroundCurrentLocation: UIButton!
    @IBOutlet weak var currentLocationLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!

    var matchingItems: [MKMapItem] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        listTableView.register(UINib(nibName: "SearchListTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchListTableViewCell")

        searchBar.delegate = self
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    @IBAction func arroundCurrentLoactionButtonAction(_ sender: Any) {
    }
}

extension SearchBarViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchListTableViewCell", for: indexPath) as? SearchListTableViewCell else {
            return UITableViewCell()
        }

        let item = matchingItems[indexPath.row]
        cell.nameLabel.text = item.placemark.title
        cell.imgView.image = UIImage(systemName: "mappin.and.ellipse")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = matchingItems[indexPath.row]
        currentLocationLabel.text = item.placemark.title
        searchBar.text = item.name
        matchingItems.removeAll()
        listTableView.reloadData()
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension SearchBarViewController : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            matchingItems.removeAll()
            listTableView.reloadData()
            return
        }

        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = searchText

        let search = MKLocalSearch(request: request)
        search.start { [weak self] response, error in
            guard let self = self, let items = response?.mapItems else { return }

            // Manually filter to match prefix
            let filtered = items.filter {
                let title = $0.placemark.title?.lowercased() ?? ""
                return title.hasPrefix(searchText.lowercased())
            }

            self.matchingItems = filtered.isEmpty ? items : filtered

            DispatchQueue.main.async {
                self.listTableView.reloadData()
            }
        }
    }
}
