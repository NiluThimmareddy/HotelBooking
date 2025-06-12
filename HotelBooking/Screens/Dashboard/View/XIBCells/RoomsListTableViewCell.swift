//
//  RoomsListTableViewCell.swift
//  HotelBooking
//
//  Created by toqsoft on 10/06/25.
//

import UIKit

class RoomsListTableViewCell: UITableViewCell {

    
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var offerCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backView.applyCardStyle()
        offerCollectionView.register(UINib(nibName: "RoomOffersCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoomOffersCollectionViewCell")
        
        if let layout = offerCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
    }

   
}

extension RoomsListTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomOffersCollectionViewCell", for: indexPath) as! RoomOffersCollectionViewCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * 0.8
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
}
