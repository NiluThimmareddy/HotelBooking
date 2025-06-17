//
//  HotelImageOverViewVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 11/06/25.
//

import UIKit

class HotelImageOverViewVC: UIViewController {

   
    @IBOutlet weak var loaderImage: UIImageView!
    @IBOutlet weak var loaderBackView: UIView!
    @IBOutlet weak var roomsTypeImagesCollectionView: UICollectionView!
    @IBOutlet weak var roomTypeCollectionView: UICollectionView!
    @IBOutlet weak var hotelTitleLbl: UILabel!
    
    var isOverviewSelected: Bool = true
    var selectedRoomTypeIndex: Int = 0
    let color = UIColor(named: "defaultColor")
    var hotelIdPass: Hotel?
    var viewModel = HotelJsonViewModel()
    var roomTypeTemplateImages = ["roomimg1","roomimg2","roomimg4","roomimg7"]
    var roomTypeTemplateTitle = ["Overview","Deluxe","Suite","Luxury"]
    var filteredRooms: [HotelRoom] {
        return viewModel.allRooms.filter { $0.hotelId == hotelIdPass?.HotelId ?? ""}
    }
    var filteredHotelImages: [HotelImage] {
        return viewModel.allhotelImages.filter { $0.hotelId == hotelIdPass?.HotelId ?? ""}
    }
    var filteredRoomType: [HotelRoom] = []
    var allRooms: [HotelRoom] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loaderImage.isHidden = true
        loaderBackView.isHidden = true
        callRoomData()
        roomsTypeImagesCollectionView.register(UINib(nibName: "RoomTypeImagesCVC", bundle: nil),forCellWithReuseIdentifier: "RoomTypeImagesCVC")
        roomTypeCollectionView.register(UINib(nibName: "RoomTypeCVC", bundle: nil),forCellWithReuseIdentifier: "RoomTypeCVC")
        hotelTitleLbl.text = hotelIdPass?.HotelName
        callImagesData()
        navigationItem.titleView = hotelTitleLbl
    }
    func callImagesData(){
        viewModel.switchDisplayMode(to: .hotelImages)

        viewModel.fetchHotels {
            DispatchQueue.main.async {
                let filtered = self.filteredHotelImages
                print("Filter Images-----> \(filtered)")
                self.roomsTypeImagesCollectionView.reloadData()
                self.roomTypeCollectionView.reloadData()
            }
        }
    }
    func callRoomData(){
        viewModel.switchDisplayMode(to: .hotelRooms)

        viewModel.fetchHotels {
            DispatchQueue.main.async {
                let filter = self.viewModel.allRooms.filter({$0.hotelId == self.hotelIdPass?.HotelId ?? "" })
                print("✅ Matched Rooms for Hotel ID\(filter)")
                let filtered = self.filteredRooms
                print("✅ Filtered Rooms for Hotel ID \(self.hotelIdPass?.HotelId ?? ""): \(filtered.count)")
                self.allRooms = self.viewModel.allRooms.filter { $0.hotelId == self.hotelIdPass?.HotelId }
                self.filteredRoomType = self.allRooms
                self.roomsTypeImagesCollectionView.reloadData()
                self.roomTypeCollectionView.reloadData()
            }
        }
    }
  

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }

}

extension HotelImageOverViewVC: UICollectionViewDelegate,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == roomTypeCollectionView{
            let width = roomTypeCollectionView.frame.size.width / 3
            let height = roomTypeCollectionView.frame.size.height
            return CGSize(width: width, height: height)
        }else{
            let width = roomsTypeImagesCollectionView.frame.size.width - 10
            let height: CGFloat = 350
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == roomTypeCollectionView{
            return  collectionView == roomTypeCollectionView ? roomTypeTemplateTitle.count : filteredRoomType.count
        }else{
            let roomImageCount = filteredRoomType.flatMap { $0.roomImages }.count
            let hotelImageCount = isOverviewSelected ? filteredHotelImages.count : 0
            let totalImages = roomImageCount + hotelImageCount
            return Int(ceil(Double(totalImages) / 3.0))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == roomTypeCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomTypeCVC", for: indexPath)as! RoomTypeCVC
            let hotelImages = filteredHotelImages.first?.imageUrl
            let roomDeluxeData = filteredRooms.filter({$0.roomType == "Deluxe"})
            let deluxeRoom = roomDeluxeData.first?.roomImages
            let roomSuiteData = filteredRooms.filter({$0.roomType == "Suite"})
            let suiteRoom = roomSuiteData.first?.roomImages
            let roomLuxuryData = filteredRooms.filter({$0.roomType == "Luxury"})
            let luxuryRoom = roomLuxuryData.first?.roomImages
            if indexPath.row == 0 {
                loadImage(from: hotelImages ?? "", into: cell.imageData)
            } else if indexPath.row == 1 {
                loadImage(from: deluxeRoom?.first ?? "", into: cell.imageData)
            } else if indexPath.row == 2 {
                loadImage(from: suiteRoom?.first ?? "", into: cell.imageData)
            } else if indexPath.row == 3 {
                loadImage(from: luxuryRoom?.first ?? "", into: cell.imageData)
            }


            cell.titleLbl.text = roomTypeTemplateTitle[indexPath.row]
            if indexPath.row == selectedRoomTypeIndex {
                cell.backView.layer.borderWidth = 2
                cell.backView.layer.borderColor = color?.cgColor
            } else {
                cell.backView.layer.borderWidth = 0
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RoomTypeImagesCVC", for: indexPath) as! RoomTypeImagesCVC
            
            let hotelImageUrls = isOverviewSelected ? filteredHotelImages.map { $0.imageUrl } : []
            let roomImageUrls = filteredRoomType.flatMap { $0.roomImages }
            let combinedImages = hotelImageUrls + roomImageUrls
            
            let startIndex = indexPath.row * 3
            let endIndex = min(startIndex + 3, combinedImages.count)
            
            if startIndex >= combinedImages.count {
                return cell
            }
            
            let imagesToShow = Array(combinedImages[startIndex..<endIndex])
            
            let imageViews = [cell.imageOne, cell.imageTwo, cell.imageThree]
            imageViews.forEach { $0?.image = nil }
            
            for (i, imageView) in imageViews.enumerated() {
                if i < imagesToShow.count {
                    loadImage(from: imagesToShow[i], into: imageView!)
                }
            }
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == roomTypeCollectionView {
            let previousIndex = selectedRoomTypeIndex
            selectedRoomTypeIndex = indexPath.row
            let previousIndexPath = IndexPath(item: previousIndex, section: 0)
            collectionView.reloadItems(at: [previousIndexPath, indexPath])
            loaderBackView.isHidden = false
            loaderImage.isHidden = false
            loaderImage.transform = .identity
            UIView.animate(withDuration: 0.5) {
                self.loaderImage.transform = CGAffineTransform(rotationAngle: .pi)
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                self.loaderBackView.isHidden = true
                self.loaderImage.isHidden = true
                self.loaderImage.transform = .identity
            }
            let selectedRoomType = roomTypeTemplateTitle[indexPath.row]
            isOverviewSelected = (selectedRoomType == "Overview")
            filteredRoomType = isOverviewSelected ? allRooms : allRooms.filter { $0.roomType == selectedRoomType }
            roomsTypeImagesCollectionView.reloadData()
        }else{
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let vc = storyboard.instantiateViewController(identifier: "ViewHotelImageVC")as! ViewHotelImageVC
            let titleValue = hotelIdPass?.HotelName
            vc.titleData = titleValue
            // Pass images based on isOverviewSelected
            if isOverviewSelected {
                // Overview: All hotel images + all room images
                let hotelImageUrls = filteredHotelImages.map { $0.imageUrl }
                let roomImageUrls = allRooms.flatMap { $0.roomImages }
                vc.images = hotelImageUrls + roomImageUrls
            } else {
                // Specific room type images
                let selectedRoomType = roomTypeTemplateTitle[selectedRoomTypeIndex]
                let selectedRoomImages = allRooms.first(where: { $0.roomType == selectedRoomType })?.roomImages ?? []
                vc.images = selectedRoomImages
            }
            navigationItem.backButtonTitle = ""
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    func loadImage(from urlString: String, into imageView: UIImageView) {
        guard let url = URL(string: urlString) else {
            imageView.image = nil
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                DispatchQueue.main.async {
                    imageView.image = UIImage(data: data)
                }
            }
        }.resume()
    }
    
}

