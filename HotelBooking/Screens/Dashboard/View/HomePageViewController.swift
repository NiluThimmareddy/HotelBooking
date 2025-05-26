//
//  HomePageViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//
/*
import UIKit

class HomePageViewController: UIViewController {

    let viewModel = HotelJsonViewModel()
    let tableView = UITableView()
    let segmentControl = UISegmentedControl(items: ["Hotels", "Seasonal Prices", "Policies", "Availability"])
    let previousButton = UIButton(type: .system)
    let nextButton = UIButton(type: .system)
    let pageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        viewModel.loadJson { success in
            if success {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
        
    }

    private func setupUI() {
        view.backgroundColor = .cyan

        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        segmentControl.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 30)
        let font = UIFont.systemFont(ofSize: 10, weight: .medium)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        segmentControl.setTitleTextAttributes(attributes, for: .normal)
        segmentControl.setTitleTextAttributes(attributes, for: .selected)
        view.addSubview(segmentControl)

        tableView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height - 160)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        previousButton.setTitle("Previous", for: .normal)
        previousButton.addTarget(self, action: #selector(didTapPrevious), for: .touchUpInside)
        previousButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        previousButton.tintColor = .black
        previousButton.frame = CGRect(x: 20, y: view.bounds.height - 60, width: 100, height: 40)
        view.addSubview(previousButton)

        nextButton.setTitle("Next", for: .normal)
        nextButton.addTarget(self, action: #selector(didTapNext), for: .touchUpInside)
        nextButton.titleLabel?.font = .systemFont(ofSize: 17, weight: .bold)
        nextButton.tintColor = .black
        nextButton.frame = CGRect(x: view.bounds.width - 120, y: view.bounds.height - 60, width: 100, height: 40)
        view.addSubview(nextButton)

        pageLabel.frame = CGRect(x: 130, y: view.bounds.height - 60, width: view.bounds.width - 260, height: 40)
        pageLabel.textAlignment = .center
        view.addSubview(pageLabel)
    }

    private func updateUI() {
        viewModel.paginate()
        tableView.reloadData()
        pageLabel.text = "Page \(viewModel.currentPage + 1) of \(viewModel.totalPages)"
        previousButton.isEnabled = viewModel.canGoToPreviousPage()
        nextButton.isEnabled = viewModel.canGoToNextPage()
    }

    @objc private func didChangeSegment() {
        let mode: DisplayMode
        switch segmentControl.selectedSegmentIndex {
        case 0: mode = .hotel
        case 1: mode = .seasonalPrice
        case 2: mode = .policy
        case 3: mode = .roomAvailability
        default: mode = .hotel
        }
        viewModel.switchDisplayMode(to: mode)
        updateUI()
    }

    @objc private func didTapPrevious() {
        viewModel.goToPreviousPage()
        updateUI()
    }

    @objc private func didTapNext() {
        viewModel.goToNextPage()
        updateUI()
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.currentItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = viewModel.currentItems[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.text = text
        return cell
    }
    
}
*/

import UIKit

class HomePageViewController: UIViewController {

    let viewModel = HotelJsonViewModel()
    let tableView = UITableView()
    let segmentControl = UISegmentedControl(items: ["Hotels", "Seasonal Prices", "Policies", "Availability"])
    let pageLabel = UILabel()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()

        viewModel.loadJson { success in
            if success {
                DispatchQueue.main.async {
                    self.updateUI()
                }
            }
        }
    }

    private func setupUI() {
        view.backgroundColor = .cyan

        segmentControl.selectedSegmentIndex = 0
        segmentControl.addTarget(self, action: #selector(didChangeSegment), for: .valueChanged)
        segmentControl.frame = CGRect(x: 20, y: 60, width: view.bounds.width - 40, height: 30)
        let font = UIFont.systemFont(ofSize: 10, weight: .medium)
        let attributes: [NSAttributedString.Key: Any] = [.font: font]
        segmentControl.setTitleTextAttributes(attributes, for: .normal)
        segmentControl.setTitleTextAttributes(attributes, for: .selected)
        view.addSubview(segmentControl)

        tableView.frame = CGRect(x: 0, y: 100, width: view.bounds.width, height: view.bounds.height - 150)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)

        pageLabel.frame = CGRect(x: 20, y: view.bounds.height - 40, width: view.bounds.width - 40, height: 30)
        pageLabel.textAlignment = .center
        view.addSubview(pageLabel)
    }

    private func updateUI() {
        tableView.reloadData()
        pageLabel.text = "Page \(viewModel.currentPage + 1) of \(viewModel.totalPages)"
    }

    @objc private func didChangeSegment() {
        let mode: DisplayMode
        switch segmentControl.selectedSegmentIndex {
        case 0: mode = .hotel
        case 1: mode = .seasonalPrice
        case 2: mode = .policy
        case 3: mode = .roomAvailability
        default: mode = .hotel
        }

        viewModel.switchDisplayMode(to: mode)
        viewModel.loadedItems.removeAll()
        viewModel.currentPage = 0

        let allItems = viewModel.allItemsForCurrentMode
        let pageSize = viewModel.pageSize

        if allItems.isEmpty {
            tableView.reloadData()
            pageLabel.text = "Page 0 of 0"
            return
        }

        let firstPageCount = min(pageSize, allItems.count)
        viewModel.loadedItems = Array(allItems[0..<firstPageCount])

        tableView.reloadData()
        tableView.setContentOffset(.zero, animated: false)

        let totalPages = (allItems.count + pageSize - 1) / pageSize
        pageLabel.text = "Page 1 of \(totalPages)"
    }
}

extension HomePageViewController: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.loadedItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.numberOfLines = 0

        if indexPath.row < viewModel.loadedItems.count {
            cell.textLabel?.text = viewModel.loadedItems[indexPath.row]
        } else {
            cell.textLabel?.text = ""
        }

        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let frameHeight = scrollView.frame.size.height

        if offsetY > contentHeight - frameHeight - 100 {
            guard viewModel.canGoToNextPage() else { return }

            viewModel.goToNextPage()

            let startIndex = viewModel.loadedItems.count - viewModel.pageSize
            let safeStartIndex = max(startIndex, 0)
            let endIndex = viewModel.loadedItems.count - 1

            var newIndexPaths: [IndexPath] = []
            for i in safeStartIndex...endIndex {
                newIndexPaths.append(IndexPath(row: i, section: 0))
            }

            tableView.performBatchUpdates({
                tableView.insertRows(at: newIndexPaths, with: .fade)
            }, completion: nil)

            pageLabel.text = "Page \(viewModel.currentPage + 1) of \(viewModel.totalPages)"
        }

        if offsetY < 50 {
            guard viewModel.canGoToPreviousPage() else { return }

            let pageSize = viewModel.pageSize
            let removeStartIndex = viewModel.currentPage * pageSize
            let removeEndIndex = removeStartIndex + pageSize - 1

            if removeStartIndex >= 0, removeEndIndex < viewModel.loadedItems.count {
                var indexPathsToRemove: [IndexPath] = []
                for i in removeStartIndex...removeEndIndex {
                    indexPathsToRemove.append(IndexPath(row: i, section: 0))
                }

                viewModel.goToPreviousPage()

                tableView.performBatchUpdates({
                    tableView.deleteRows(at: indexPathsToRemove, with: .fade)
                }, completion: nil)

                pageLabel.text = "Page \(viewModel.currentPage + 1) of \(viewModel.totalPages)"
            }
        }
    }
    
}
