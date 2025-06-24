//
//  RoomsListTableViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 10/06/25.
//

import UIKit
import SkeletonView

class RoomsListTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var adultsCountLabel: UILabel!
    @IBOutlet weak var bedsCountLabel: UILabel!
    @IBOutlet weak var roomSizeLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        isSkeletonable = true
        contentView.isSkeletonable = true
        
        [backView, offerCollectionView, roomTypeLabel, adultsCountLabel, bedsCountLabel, roomSizeLabel].forEach {
            $0?.isSkeletonable = true
        }
        contentView.makeAllSubviewsSkeletonable()
        
        backView.applyCardStyle()

        offerCollectionView.register(UINib(nibName: "RoomOffersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoomOffersCollectionViewCell")

        if let layout = offerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }

        offerCollectionView.isSkeletonable = true
        offerCollectionView.dataSource = self
        offerCollectionView.delegate = self
    }
}

extension RoomsListTableViewCell: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "RoomOffersCollectionViewCell"
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomOffersCollectionViewCell", for: indexPath) as! RoomOffersCollectionViewCell
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = UIDevice.current.userInterfaceIdiom == .pad ? collectionView.frame.width * 0.4 : collectionView.frame.width * 0.8
        return CGSize(width: itemWidth, height: collectionView.frame.height)
    }
}

