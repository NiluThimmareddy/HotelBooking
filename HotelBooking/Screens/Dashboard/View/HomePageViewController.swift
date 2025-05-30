//
//  HomePageViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

import UIKit

class HomePageViewController: UIViewController {
    
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var hotelListCollectionView: UICollectionView!
    @IBOutlet weak var hotelRoomCollectionView: UICollectionView!
    @IBOutlet weak var propertyTypeCollectionView: UICollectionView!
    
    let viewModel = HotelJsonViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchView.applyCardStyle()
        
        hotelListCollectionView.register(UINib(nibName: "RecommendedHotelsCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendedHotelsCVC")
        hotelRoomCollectionView.register(UINib(nibName: "RecommendedRoomsLwrCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendedRoomsLwrCVC")
        propertyTypeCollectionView.register(UINib(nibName: "PropertyTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PropertyTypeCVC")
        
        if let layout = hotelListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        if let layouts = hotelRoomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
        }
        
        if let PropertyLayouts = propertyTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            PropertyLayouts.estimatedItemSize = .zero
        }
        
        viewModel.fetchHotels {
            DispatchQueue.main.async {
                self.hotelListCollectionView.reloadData()
                self.hotelRoomCollectionView.reloadData()
                self.propertyTypeCollectionView.reloadData()
            }
        }
        
    }

    @IBAction func searchButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == hotelListCollectionView {
            return min(6, viewModel.allHotels.count)
        } else if collectionView == hotelRoomCollectionView {
            return min(6, viewModel.allRooms.count)
        } else {
            return min(6, viewModel.allHotels.count)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == hotelListCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedHotelsCVC", for: indexPath) as! RecommendedHotelsCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
        } else if collectionView == hotelRoomCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedRoomsLwrCVC", for: indexPath) as! RecommendedRoomsLwrCVC
            let item = viewModel.allRooms[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyTypeCVC", for: indexPath) as! PropertyTypeCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
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
