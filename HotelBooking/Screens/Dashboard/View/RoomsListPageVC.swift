//
//  RoomsListPageVC.swift
//  HotelBooking
//
//  Created by toqsoft on 09/06/25.
//

import UIKit
import SkeletonView

protocol ThirdStepVCDelegate: AnyObject {
    func navigateToBookingOverview()
}

class RoomsListPageVC: UIViewController, ThirdStepVCDelegate, RoomsListTVCDelegate {

    @IBOutlet weak var roomsListTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    @IBOutlet weak var bottomViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var selectedRoomPriceLabel: UILabel!
    @IBOutlet weak var totalRoomsCountLabel: UILabel!
    @IBOutlet weak var downTriangleImgView: UIImageView!
    
    var filterOptions = ["🎁 Hotel offers","Breakfast included","Free cancellation"]
    var hotelDetailsData: Hotel?
    var hotelIdPass: Hotel?
    
    let viewModel = HotelJsonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
        
        let titleLabel = UILabel()
        titleLabel.numberOfLines = 2
        titleLabel.textAlignment = .left
         
        let titleText = NSMutableAttributedString(string: "Select room\n", attributes: [
            .font: UIFont.boldSystemFont(ofSize: 16),
            .foregroundColor: UIColor.white
        ])
        titleText.append(NSAttributedString(string: "03-July to 05-July ", attributes: [
            .font: UIFont.systemFont(ofSize: 14),
            .foregroundColor: UIColor.white
        ]))
         
        titleLabel.attributedText = titleText
        titleLabel.sizeToFit()
         
        self.navigationItem.titleView = titleLabel
    }

    func navigateToBookingOverview() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "BookingOverviewVC") as! BookingOverviewVC
        vc.navigationItem.title = "Booking Overview"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func didTapSelectImagesButton(in cell: RoomsListTVC) {
        let controller = UIStoryboard(name: "HomePage", bundle: nil).instantiateViewController(withIdentifier: "HotelImageOverViewVC") as! HotelImageOverViewVC
        let titleValue = hotelDetailsData
        controller.hotelIdPass = titleValue
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func didTapSelectRoom(in cell: RoomsListTVC, room: HotelRoom) {
        bottomView.isHidden = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            bottomViewHeightConstraint.constant = 100
        } else {
            bottomViewHeightConstraint.constant = 80
        }

        selectedRoomPriceLabel.text = "$ \(room.basePrice)"

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }

    @IBAction func continueButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "FirstStepVC") as? FirstStepVC else { return }
        controller.delegate = self
        if let sheet = controller.sheetPresentationController {
            let heightFactor: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.35 : 0.46
            
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * heightFactor
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                sheet.largestUndimmedDetentIdentifier = .medium
                controller.preferredContentSize = CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * heightFactor
                )
            }
        }
        
        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }
}

extension RoomsListPageVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filterOptions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FilterRoomsCVC", for: indexPath) as! FilterRoomsCVC
        cell.filterButton.setTitle(filterOptions[indexPath.row], for: .normal)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return -5
    }

}
extension RoomsListPageVC: SkeletonTableViewDataSource, UITableViewDelegate {

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RoomsListTVC"
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return min(5, viewModel.allRooms.count)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListTVC") as! RoomsListTVC
        cell.delegate = self
        let rooms = viewModel.allRooms[indexPath.row]
        cell.configure(with: rooms)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIDevice.current.userInterfaceIdiom == .pad ? 400 : 366
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "RoomDetailsPage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RoomDetailsPageViewController") as! RoomDetailsPageViewController
        controller.navigationItem.title = "Room Details"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
}

extension RoomsListPageVC {
    func setUpUI() {
        bottomView.addTopShadow()
        bottomView.isHidden = true
        bottomViewHeightConstraint.constant = 0

        filterCollectionView.register(UINib(nibName: "FilterRoomsCVC", bundle: nil), forCellWithReuseIdentifier: "FilterRoomsCVC")
        roomsListTableView.register(UINib(nibName: "RoomsListTVC", bundle: nil), forCellReuseIdentifier: "RoomsListTVC")
       
        [roomsListTableView,totalRoomsCountLabel,downTriangleImgView].forEach { skeltonView in
            skeltonView.isSkeletonable = true
            skeltonView.showAnimatedGradientSkeleton()
        }

        viewModel.fetchHotels {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                [self.roomsListTableView, self.totalRoomsCountLabel, self.downTriangleImgView].forEach { skeletonView in
                    skeletonView?.stopSkeletonAnimation()
                    skeletonView?.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                }

                let visibleRoomCount = min(5, self.viewModel.allRooms.count)
                self.totalRoomsCountLabel.text = "\(visibleRoomCount) room type\(visibleRoomCount == 1 ? "" : "s")"
            }
        }
        
    }
}
