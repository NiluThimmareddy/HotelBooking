//
//  RoomDetailsRoomImagesTableViewCell.swift
//  HotelBooking
//
//  Created by ToqSoft on 16/06/25.
//

import UIKit

class RoomDetailsRoomImagesTableViewCell: UITableViewCell {

    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var roomImagesCollectionView: UICollectionView!
    
    @IBOutlet weak var pageControl: UIPageControl!
    
    var roomsImages = ["ic_room1","ic_room2","ic_room3","ic_room4","ic_room5","ic_room6"]
    var timer: Timer?
    var currentIndex = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setUpUI()
        startTimer()
    }
    
    deinit {
        stopTimer()
    }
  
    @IBAction func pageControlAction(_ sender: Any) {
        
    }
}
 
extension RoomDetailsRoomImagesTableViewCell : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return roomsImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomImagesCollectionViewCell", for: indexPath) as! RoomImagesCollectionViewCell
        cell.roomImagesList.image = UIImage(named: roomsImages[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
  
}
 
extension RoomDetailsRoomImagesTableViewCell {
    func setUpUI() {
        
       
        backView.applyCardStyle()
        roomImagesCollectionView.register(UINib(nibName: "RoomImagesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RoomImagesCollectionViewCell")
        
        if let layout = roomImagesCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
            layout.estimatedItemSize = .zero
        }
        
        roomImagesCollectionView.showsHorizontalScrollIndicator = false
        
        pageControl.numberOfPages = roomsImages.count
        pageControl.currentPage = 0
        currentIndex = 0
        roomImagesCollectionView.reloadData()
        
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(scrollToNextImage), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func scrollToNextImage() {
        if roomsImages.isEmpty { return }
        
        currentIndex += 1
        if currentIndex >= roomsImages.count {
            currentIndex = 0
        }
        
        let indexPath = IndexPath(item: currentIndex, section: 0)
        roomImagesCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageControl.currentPage = currentIndex
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        stopTimer()
    }
 
}
