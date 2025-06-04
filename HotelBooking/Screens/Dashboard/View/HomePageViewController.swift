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
    
    let viewModel = HotelJsonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
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

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bestPlaceImgView.applyStrongLeftGradient()
    }
    
    @IBAction func selectdateButtonAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "CalenderVC") as! CalenderVC
        controller.delegate = self
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * 0.85
                }
            ]
            sheet.prefersGrabberVisible = true
        }
        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }
    
    func didSelectDateRange(_ dateRangeText: String) {
        selectdateButton.setTitle(dateRangeText, for: .normal)
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
        if collectionView == hotelListCollectionView {
            return min(6, viewModel.allHotels.count)
        } else if collectionView == hotelRoomCollectionView {
            return min(6, viewModel.allRooms.count)
        } else if collectionView == propertyTypeCollectionView {
            return min(6, viewModel.allHotels.count)
        } else {
            return viewModel.bankImages.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotelListCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedHotelsLwrCVC", for: indexPath) as! RecommendedHotelsLwrCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
        } else if collectionView == hotelRoomCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedRoomsLwrCVC", for: indexPath) as! RecommendedRoomsLwrCVC
            let item = viewModel.allRooms[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
        } else if collectionView == propertyTypeCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyTypeCVC", for: indexPath) as! PropertyTypeCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopOffersCVC", for: indexPath) as! TopOffersCVC
            cell.configure(viewModel: viewModel, index: indexPath.row)

            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
//        self.navigationController?.navigationBar.tintColor = .white
//        self.navigationController?.pushViewController(controller, animated: true)
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



