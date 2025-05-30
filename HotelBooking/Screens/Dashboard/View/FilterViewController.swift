import UIKit

struct FilterOption {
    let title: String
    var isSelected: Bool
}

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var filtersBySection: [String: [FilterOption]] = [
           "Suggested For You": [FilterOption(title: "Last Minute Deals", isSelected: false),
                                 FilterOption(title: "5 Star", isSelected: false),
                                 FilterOption(title: "North Goa", isSelected: false),
                                 FilterOption(title: "Resorts", isSelected: false),
                                 FilterOption(title: "Free Cancellation", isSelected: false),
                                 FilterOption(title: "Calangute", isSelected: false),
                                 FilterOption(title: "Candolim", isSelected: false)],
           "Price per night": [
               FilterOption(title: "₹ 0-2000", isSelected: false),
               FilterOption(title: "₹ 2000-4000", isSelected: false),
               FilterOption(title: "₹ 4000-7500", isSelected: false),
               FilterOption(title: "₹ 7500-11000", isSelected: false),
               FilterOption(title: "₹ 11000-15000", isSelected: false),
               FilterOption(title: "₹ 15000-30000", isSelected: false),
               FilterOption(title: "₹ 30000+", isSelected: false)
              
           ],
           "Star Category": [
               FilterOption(title: "3 Star", isSelected: false),
               FilterOption(title: "4 Stari", isSelected: false),
               FilterOption(title: "5 Star", isSelected: false)
           ],
           "Super Packages": [
               FilterOption(title: "Super Packages", isSelected: false)
               
           ],
           "Property Type" : [FilterOption(title: "Homestays", isSelected: false),
                 FilterOption(title: "Apartments", isSelected: false),
                 FilterOption(title: "Villas", isSelected: false),
                 FilterOption(title: "Resort", isSelected: false),
                 FilterOption(title: "Lodges", isSelected: false)]
       ] 

    var sectionTitles: [String] {
        return Array(filtersBySection.keys)
    }

    let tableView = UITableView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FilterCell.self, forCellReuseIdentifier: "FilterCell")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionKey = sectionTitles[section]
        return filtersBySection[sectionKey]?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let sectionKey = sectionTitles[indexPath.section]
        guard let filters = filtersBySection[sectionKey] else { return UITableViewCell() }

        let filter = filters[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "FilterCell", for: indexPath) as? FilterCell else {
            return UITableViewCell()
        }

        cell.configure(with: filter.title, isSelected: filter.isSelected)
        cell.selectionStyle = .none
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let sectionKey = sectionTitles[indexPath.section]
        filtersBySection[sectionKey]?[indexPath.row].isSelected.toggle()
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}

