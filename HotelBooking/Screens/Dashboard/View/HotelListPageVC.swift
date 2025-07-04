//
//  HotelListPageVC.swift
//  HotelBooking
//
//  Created by toqsoft on 28/05/25.
//

import UIKit
import SkeletonView

class HotelListPageVC: UIViewController, ScrollToTopCapable, CalenderVCDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var hotelListTableview: UITableView!
    @IBOutlet weak var filterButton: UIButton!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var sortView: UIView!
    @IBOutlet weak var filterView: UIView!
    @IBOutlet weak var selectDateButton: UIButton!
    @IBOutlet weak var selectnameButton: UIButton!
    @IBOutlet weak var filterStackView: UIStackView!    
    @IBOutlet weak var topSheetView: UIView!
    @IBOutlet weak var selectedDatesButton: UIButton!
    @IBOutlet weak var selectRoomAdultButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var topSheetBottomView: UIView!
    
    let viewModel = HotelJsonViewModel()
    var selectedSortOption: String?
    var isClicked: Bool = false
    var scrollToTopButton = UIButton(type: .system)
    var scrolltoTopHelper : ScrollToTopHelper!
    var hotelImages = ["hotel_2", "hotel_3", "hotel_4", "hotel_5", "hotel_6", "hotel_7"]
    var shuffledHotelImages: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    var tableView: UITableView { hotelListTableview}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        filterStackView.addBottomShadow()
    }
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func moreButtonAction(_ sender: Any) {
    }
    
    @IBAction func selectDateButtonAction(_ sender: Any) {
        let animationDuration = 0.6
        
        if topSheetView.isHidden {
            topSheetView.isHidden = false
            topSheetView.transform = CGAffineTransform(translationX: 0, y: -topSheetView.frame.height)
            
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseOut]) {
                self.topSheetView.transform = .identity
            }
        } else {
            UIView.animate(withDuration: animationDuration, delay: 0, options: [.curveEaseIn], animations: {
                self.topSheetView.transform = CGAffineTransform(translationX: 0, y: -self.topSheetView.frame.height)
            }, completion: { _ in
                self.topSheetView.isHidden = true
            })
        }
    }
    
    @IBAction func selectedDatesButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "CalenderVC") as? CalenderVC else { return }
        controller.delegate = self
        
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * 0.65
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
        
        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }
    
    @IBAction func selectRoomAdultsButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SelectRoomsAndGuestsVC") as? SelectRoomsAndGuestsVC else { return }

        if let sheet = controller.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom(identifier: .medium, resolver: { context in
                        return context.maximumDetentValue * 0.65
                    })
                ]
                sheet.selectedDetentIdentifier = .medium
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20

                if UIDevice.current.userInterfaceIdiom == .pad {
                    sheet.largestUndimmedDetentIdentifier = nil
                    controller.preferredContentSize = CGSize(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height * 0.5
                    )
                }
            }
        }

        controller.modalPresentationStyle = .pageSheet

        controller.onApply = { [weak self] rooms, adults, children in
            let title = "\(rooms) Room\(rooms > 1 ? "s" : "") , \(adults) Adult\(adults > 1 ? "s" : "")" + (children > 0 ? " , \(children) Child\(children > 1 ? "ren" : "")" : "")
            self?.selectRoomAdultButton.setTitle(title, for: .normal)
        }

        present(controller, animated: true)
    }

    @IBAction func searchButtonAction(_ sender: Any) {
    }
    
    @IBAction func selectNameButtonAction(_ sender: Any) {
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

        let rotatedImages = Array(hotelImages.shuffled())
        var imageChunk: [String] = []
        for i in 0..<3 {
            let index = (indexPath.row + i) % rotatedImages.count
            imageChunk.append(rotatedImages[index])
        }

        cell.configure(with: hotel, room: cheapestRoom, policy: policy, distance: nearBy, imageNames: imageChunk)

        return cell
    }


    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 390 : 370
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
    
    func didSelectDateRange(_ dateRangeText: String) {
        selectedDatesButton.setTitle(dateRangeText, for: .normal)
    }
    
    func setUpUI() {
        hotelListTableview.register(UINib(nibName: "HotelsListTVC", bundle: nil), forCellReuseIdentifier: "HotelsListTVC")

        DispatchQueue.main.async {
            self.selectDateButton.addBorder(edge: .right, color: .systemGray4, thickness: 0.8)
            self.selectnameButton.addBorder(edge: .left, color: .systemGray4, thickness: 0.8)
            self.sortButton.addBorder(edge: .right, color: .systemGray5, thickness: 0.8)
            self.filterButton.addBorder(edge: .left, color: .systemGray5, thickness: 0.8)
        }

        hotelListTableview.isSkeletonable = true
        hotelListTableview.showAnimatedGradientSkeleton()
        
        viewModel.fetchHotels {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.hotelListTableview.stopSkeletonAnimation()
                self.hotelListTableview.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            }
        }
        
        scrollToTopButton.setImage(UIImage(systemName: "arrow.up.to.line.compact"), for: .normal)
        scrollToTopButton.imageView?.contentMode = .scaleToFill
        
        scrolltoTopHelper = ScrollToTopHelper(parent: self)
        shuffledHotelImages = hotelImages.shuffled()
        
        [topSheetView,topSheetBottomView].forEach { view in
            view.clipsToBounds = true
            view.layer.cornerRadius = 20
            view.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        }
        topSheetView.applyCardStyle()
        
        topSheetView.transform = CGAffineTransform(translationX: 0, y: -topSheetView.frame.height)
        topSheetView.isHidden = true

        if UIDevice.current.userInterfaceIdiom == .pad {
            topView.layer.cornerRadius = 25
        } else {
            topView.layer.cornerRadius = 15
        }
    }

}

