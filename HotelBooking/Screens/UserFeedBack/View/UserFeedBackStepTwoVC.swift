//
//  UserFeedBackStepTwoVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 16/06/25.
//

import UIKit

class UserFeedBackStepTwoVC: UIViewController {

    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var howManyDayAndPlace: UILabel!
    @IBOutlet weak var bookingDate: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var sharePhotosCV: UICollectionView!
    @IBOutlet weak var bonusQuestionCV: UICollectionView!
    @IBOutlet weak var meetYourExpectationTV: UITableView!
    @IBOutlet weak var whatDidNotYouLikeTextView: UITextView!
    @IBOutlet weak var whatDidYouLikeTextView: UITextView!
    
    var selectedExpectationIndex: Int? = nil
    var expectationData = ["No","Yes","It exceeded my expectations"]
    var emojiImage = ["frown","meh","smile","laugh"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        whatDidYouLikeTextView.layer.borderColor = UIColor.lightGray.cgColor
        whatDidYouLikeTextView.layer.borderWidth = 2
        whatDidNotYouLikeTextView.layer.borderColor = UIColor.lightGray.cgColor
        whatDidNotYouLikeTextView.layer.borderWidth = 2
        hotelName.text = "Review: Treebo Emirates Suites Indiranagar"
        meetYourExpectationTV.register(UINib(nibName: "ExpectationMeetsTVC", bundle: nil), forCellReuseIdentifier: "ExpectationMeetsTVC")
        bonusQuestionCV.register(UINib(nibName: "BonusQuestionCVC", bundle: nil), forCellWithReuseIdentifier: "BonusQuestionCVC")
        sharePhotosCV.register(UINib(nibName: "ShareImageCVC", bundle: nil), forCellWithReuseIdentifier: "ShareImageCVC")
        navigationProcess()
    }
    func navigationProcess(){
        let titleLabel = UILabel()
        titleLabel.text = "Step 2 of 2"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center

        navigationItem.titleView = titleLabel
    }

   
    @IBAction func finisgButton(_ sender: Any) {
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension UserFeedBackStepTwoVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expectationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExpectationMeetsTVC")as! ExpectationMeetsTVC
        let isSelected = indexPath.row == selectedExpectationIndex
        cell.tickImage.image = UIImage(named: isSelected ? "circle-check" : "circle")
        cell.titleLbl.text = expectationData[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedExpectationIndex = indexPath.row
        meetYourExpectationTV.reloadData()
      
       
    }

    
}

extension UserFeedBackStepTwoVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == bonusQuestionCV{
            let width = ( bonusQuestionCV.frame.size.width - 10) / 4
            let height = ( bonusQuestionCV.frame.size.height - 10)
            return CGSize(width: width, height: height)
        }else{
            let width = (sharePhotosCV.frame.size.width - 10) / 3
            let height = (sharePhotosCV.frame.size.height - 10)
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bonusQuestionCV{
            return 4
        }else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bonusQuestionCV{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BonusQuestionCVC", for: indexPath)as! BonusQuestionCVC
            let images = emojiImage[indexPath.row]
            cell.emojiImage.image = UIImage(named: images)
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareImageCVC", for: indexPath)as! ShareImageCVC
            cell.selectImageButton
            cell.sharedImage.image = UIImage(named: "plus")
            return cell
        }
    }
    
}
