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

class RoomsListPageVC: UIViewController, ThirdStepVCDelegate {

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var roomsListTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var filterCollectionView: UICollectionView!
    
    var filterOptions = ["Hotel offers","Breakfast included","Free cancellation"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpUI()
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
    
    @IBAction func selectButtonAction(_ sender: UIBarButtonItem) {}

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
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListTVC") as! RoomsListTVC
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 350
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

        filterCollectionView.register(UINib(nibName: "FilterRoomsCVC", bundle: nil), forCellWithReuseIdentifier: "FilterRoomsCVC")
        roomsListTableView.register(UINib(nibName: "RoomsListTVC", bundle: nil), forCellReuseIdentifier: "RoomsListTVC")
       
        roomsListTableView.isSkeletonable = true
        roomsListTableView.showAnimatedGradientSkeleton()

        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.roomsListTableView.stopSkeletonAnimation()
            self.roomsListTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
        }
    }
}
