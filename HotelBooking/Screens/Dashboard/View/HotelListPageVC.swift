//
//  HotelListPageVC.swift
//  HotelBooking
//
//  Created by toqsoft on 28/05/25.
//

import UIKit
import SkeletonView

class HotelListPageVC: UIViewController, ScrollToTopCapable {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var hotelListTableview: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!

    let viewModel = HotelJsonViewModel()

    var selectedSortOption: String?

    var isClicked: Bool = false

    var scrollToTopButton = UIButton(type: .system)
    var scrolltoTopHelper : ScrollToTopHelper!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaultNavigationBarAppearance()
        setUpUI()
    }

    var tableView: UITableView { hotelListTableview}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDefaultNavigationBarAppearance()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupDefaultNavigationBarDisAppearance()
    }
    func setupDefaultNavigationBarAppearance() {
        if let color = UIColor(named: "defaultColor") {
            navigationController?.navigationBar.barTintColor = color
            navigationController?.navigationBar.backgroundColor = color
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.tintColor = .white
        }
    }
    func setupDefaultNavigationBarDisAppearance() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }
    @IBAction func sortButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SortFilterViewController") as? SortFilterViewController else { return }

        if let sheet = controller.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        return context.maximumDetentValue * 0.57
                    } else {
                        return context.maximumDetentValue * 0.73
                    }
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20

            if UIDevice.current.userInterfaceIdiom == .pad {
                sheet.largestUndimmedDetentIdentifier = .medium
                controller.preferredContentSize = CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * 0.5
                )
            }
        }
        controller.delegate = self
        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }

    @IBAction func filterButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "FilterOptionsViewController") as? FilterOptionsViewController else { return }

        if let sheet = controller.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * 0.83
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20

            if UIDevice.current.userInterfaceIdiom == .pad {
                sheet.largestUndimmedDetentIdentifier = .medium
                controller.preferredContentSize = CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * 0.6
                )
            }
        }

        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }
}

extension HotelListPageVC: UITableViewDelegate, SkeletonTableViewDataSource {

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
        let policy = viewModel.allPolicies[indexPath.row]
        let nearBy = viewModel.allHotelNearbyLandmarks[indexPath.row]

        cell.configure(with: hotel, room: cheapestRoom, policy: policy, distance: nearBy)

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 460 : 390
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "DetailsViewController") as! DetailsViewController
        controller.hotelDetailsData = viewModel.allHotels[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(controller, animated: true)
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "HotelsListTVC"
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrolltoTopHelper.scrollViewDidScroll(scrollView)
    }
}

extension HotelListPageVC {
    func setUpUI() {
        hotelListTableview.register(UINib(nibName: "HotelsListTVC", bundle: nil), forCellReuseIdentifier: "HotelsListTVC")



        hotelListTableview.isSkeletonable = true
        hotelListTableview.showAnimatedGradientSkeleton()
        
        viewModel.fetchHotels {
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                self.hotelListTableview.stopSkeletonAnimation()
                self.hotelListTableview.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            }
        }
        
        scrollToTopButton.setImage(UIImage(systemName: "arrow.up.to.line.compact"), for: .normal)
        scrollToTopButton.imageView?.contentMode = .scaleToFill
        
        scrolltoTopHelper = ScrollToTopHelper(parent: self)
    }

}

