//
//  HomePageViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import UIKit

class HomePageViewController: UIViewController, CalenderVCDelegate {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var hotelListCollectionView: UICollectionView!
    @IBOutlet weak var hotelRoomCollectionView: UICollectionView!
    @IBOutlet weak var propertyTypeCollectionView: UICollectionView!
    @IBOutlet weak var selectdateButton: UIButton!
    @IBOutlet weak var dealsView: UIView!
    @IBOutlet weak var bestPlaceImgView: UIImageView!
    @IBOutlet weak var dealsTitleLabel: UILabel!
    @IBOutlet weak var selectionDateLabel: UILabel!
    @IBOutlet weak var seeDealsButton: UIButton!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    @IBOutlet weak var roomAndAdultsButton: UIButton!
    
    let viewModel = HotelJsonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bestPlaceImgView.applyStrongLeftGradient()
    }

    @IBAction func selectdateButtonAction(_ sender: Any) {
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
    
    func didSelectDateRange(_ dateRangeText: String) {
        selectdateButton.setTitle(dateRangeText, for: .normal)
    }
    
    @IBAction func roomAndAdultsButtonAction(_ sender: Any) {
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
            self?.roomAndAdultsButton.setTitle(title, for: .normal)
        }

        present(controller, animated: true)
    }


    @IBAction func searchButtonAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func seeDealsButtonAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hotelListCollectionView, propertyTypeCollectionView:
            return min(6, viewModel.allHotels.count)
        case hotelRoomCollectionView:
            return min(6, viewModel.allRooms.count)
        default:
            return viewModel.bankImages.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case hotelListCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedHotelsLwrCVC", for: indexPath) as! RecommendedHotelsLwrCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        case hotelRoomCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedRoomsLwrCVC", for: indexPath) as! RecommendedRoomsLwrCVC
            let item = viewModel.allRooms[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        case propertyTypeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyTypeCVC", for: indexPath) as! PropertyTypeCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopOffersCVC", for: indexPath) as! TopOffersCVC
            cell.configure(viewModel: viewModel, index: indexPath.row)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        controller.hotelDetailsData = viewModel.allHotels[indexPath.row]
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)

        switch collectionView {
        case hotelListCollectionView:
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
        case hotelRoomCollectionView:
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "RoomsListPageVC") as! RoomsListPageVC
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
        case propertyTypeCollectionView:
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
            controller.modalPresentationStyle = .fullScreen
            present(controller, animated: true)
        default :
            break
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * 0.49
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
    
    

}

extension HomePageViewController {
    func setUpUI() {
        searchView.applyCardStyle()
        
        hotelListCollectionView.register(UINib(nibName: "RecommendedHotelsLwrCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendedHotelsLwrCVC")
        hotelRoomCollectionView.register(UINib(nibName: "RecommendedRoomsLwrCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendedRoomsLwrCVC")
        propertyTypeCollectionView.register(UINib(nibName: "PropertyTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PropertyTypeCVC")
        offersCollectionView.register(UINib(nibName: "TopOffersCVC", bundle: nil), forCellWithReuseIdentifier: "TopOffersCVC")
        
        if let layout = hotelListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        if let layouts = hotelRoomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
        }
        
        if let propertyLayouts = propertyTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            propertyLayouts.estimatedItemSize = .zero
        }
        
        if let offersLayouts = offersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            offersLayouts.estimatedItemSize = .zero
        }
        
        viewModel.fetchHotels {
            DispatchQueue.main.async {
                self.hotelListCollectionView.reloadData()
                self.hotelRoomCollectionView.reloadData()
                self.propertyTypeCollectionView.reloadData()
                self.offersCollectionView.reloadData()
            }
        }
        
    }
}

