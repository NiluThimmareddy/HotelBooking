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
    
    private let titleDataLabel = UILabel()
    private let photosCountDataLbl = UILabel()


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
        navigationProcess()
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        photosCountDataLbl.text = "Photo \(pageIndex + 1) of \(images.count)"
    }

    func navigationProcess() {
        titleDataLabel.text = titleData
        titleDataLabel.textColor = .white
        titleDataLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleDataLabel.textAlignment = .center

        photosCountDataLbl.text = "Photo 1 of \(images.count)"
        photosCountDataLbl.textColor = .white
        photosCountDataLbl.font = UIFont.systemFont(ofSize: 13)
        photosCountDataLbl.textAlignment = .center

        let titleStack = UIStackView(arrangedSubviews: [titleDataLabel, photosCountDataLbl])
        titleStack.axis = .vertical
        titleStack.alignment = .center
        titleStack.spacing = 2

        navigationItem.titleView = titleStack
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
        let urlString = images[indexPath.row]
            
            if let url = URL(string: urlString) {
                URLSession.shared.dataTask(with: url) { data, _, error in
                    if let data = data, error == nil {
                        DispatchQueue.main.async {
                            cell.viewHotelImages.image = UIImage(data: data)
                        }
                    } else {
                        DispatchQueue.main.async {
                            cell.viewHotelImages.image = UIImage(named: "placeholderImage") 
                        }
                    }
                }.resume()
            } else {
                cell.viewHotelImages.image = UIImage(named: "placeholderImage")
            }
            
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.frame.size
    }

    
}
