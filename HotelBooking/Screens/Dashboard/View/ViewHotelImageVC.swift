//
//  ViewHotelImageVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 28/05/25.
//

import UIKit

class ViewHotelImageVC: UIViewController {
    var images: [String] = []
    var titleData: String?
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var photosCountLbl: UILabel!
    @IBOutlet weak var imageViewCollectionVIew: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLable.text = titleData
        photosCountLbl.text = "Photo 1 of \(images.count)"
        imageViewCollectionVIew.register(UINib(nibName: "ViewHotelImageCVC", bundle: nil), forCellWithReuseIdentifier: "ViewHotelImageCVC")
        if let layout = imageViewCollectionVIew.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        imageViewCollectionVIew.isPagingEnabled = true

    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        photosCountLbl.text = "Photo \(pageIndex + 1) of \(images.count)"
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func closeButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
}

extension ViewHotelImageVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ViewHotelImageCVC", for: indexPath)as! ViewHotelImageCVC
        let data = images[indexPath.row]
        cell.viewHotelImages.image = UIImage(named: data)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    
}
