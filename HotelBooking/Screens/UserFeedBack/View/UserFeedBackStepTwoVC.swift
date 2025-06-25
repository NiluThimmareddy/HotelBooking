//
//  UserFeedBackStepTwoVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 16/06/25.
//

import UIKit
import PhotosUI


class UserFeedBackStepTwoVC: UIViewController {

    @IBOutlet weak var dontWorryLbl: UILabel!
    @IBOutlet weak var shareYourPhontosLbl: UILabel!
    @IBOutlet weak var bomusQuestionLbl: UILabel!
    @IBOutlet weak var didThePropertyMeetYourExpectationsLbl: UILabel!
    @IBOutlet weak var geivwYourReviewTitleTF: UITextField!
    @IBOutlet weak var shortLbl: UILabel!
    @IBOutlet weak var whatDidntYouLikeLbl: UILabel!
    @IBOutlet weak var longLbl: UILabel!
    @IBOutlet weak var hoteImage: UIImageView!
    @IBOutlet weak var whatDidYouLikeLbl: UILabel!
    @IBOutlet weak var couldYouTellUsaLittleMoreLbl: UILabel!
    @IBOutlet weak var scrollViewScroll: UIScrollView!
    @IBOutlet weak var bonusQuestionCurrentAndTotalCount: UILabel!
    @IBOutlet weak var pageControllerForBonusQuestionCv: UIPageControl!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var howManyDayAndPlace: UILabel!
    @IBOutlet weak var bookingDate: UILabel!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var sharePhotosCV: UICollectionView!
    @IBOutlet weak var bonusQuestionCV: UICollectionView!
    @IBOutlet weak var meetYourExpectationTV: UITableView!
    @IBOutlet weak var whatDidNotYouLikeTextView: UITextView!
    @IBOutlet weak var whatDidYouLikeTextView: UITextView!
    
    let color = UIColor(named: "defaultColor")
    var selectedRatings: [Int?] = Array(repeating: nil, count: 4)
    var bonusQuestion = [" How would you rate the size of your room?","How comfy were the beds?","How satisfied were you with your room?","How were the facilities in your room?"]
    var selectedExpectationIndex: Int? = nil
    var expectationData = ["No","Yes","It exceeded my expectations"]
    var emojiImage = ["angry","frown","meh","smile","laugh"]
    var selectedImages: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bonusQuestionCV.isPagingEnabled = true
        whatDidYouLikeTextView.layer.borderColor = UIColor.lightGray.cgColor
        whatDidYouLikeTextView.layer.borderWidth = 2
        whatDidNotYouLikeTextView.layer.borderColor = UIColor.lightGray.cgColor
        whatDidNotYouLikeTextView.layer.borderWidth = 2
        hotelName.text = "Review: Treebo Emirates Suites Indiranagar"
        meetYourExpectationTV.register(UINib(nibName: "ExpectationMeetsTVC", bundle: nil), forCellReuseIdentifier: "ExpectationMeetsTVC")
        bonusQuestionCV.register(UINib(nibName: "BonusQuestionCVC", bundle: nil), forCellWithReuseIdentifier: "BonusQuestionCVC")
        sharePhotosCV.register(UINib(nibName: "ShareImageCVC", bundle: nil), forCellWithReuseIdentifier: "ShareImageCVC")
        navigationProcess()
        applyFontText()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        pageControllerForBonusQuestionCv.numberOfPages = bonusQuestion.count
        pageControllerForBonusQuestionCv.currentPage = 0
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    func applyFontText(){
        hotelName.font = .poppinsBold(25)
        howManyDayAndPlace.font = .poppinsMedium(12)
        bookingDate.font = .poppinsMedium(12)
        dontWorryLbl.font = .poppinsMedium(12)
        couldYouTellUsaLittleMoreLbl.font = .poppinsBold(16)
        whatDidYouLikeLbl.font = .poppinsMedium(14)
        whatDidntYouLikeLbl.font = .poppinsMedium(14)
        longLbl.font = .poppinsMedium(14)
        shortLbl.font = .poppinsMedium(14)
        didThePropertyMeetYourExpectationsLbl.font = .poppinsMedium(14)
        bomusQuestionLbl.font = .poppinsMedium(14)
        bonusQuestionCurrentAndTotalCount.font = .poppinsMedium(14)
        shareYourPhontosLbl.font = .poppinsMedium(14)
        let Finish = NSAttributedString(
            string: "Finish",
            attributes: [.font: UIFont.poppinsBold(16), .foregroundColor: UIColor.white]
        )
        finishButton.setAttributedTitle(Finish, for: .normal)
        
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        let keyboardHeight = keyboardFrame.height

        scrollViewScroll.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight + 20, right: 0)
        scrollViewScroll.scrollIndicatorInsets = scrollViewScroll.contentInset

        // Scroll to the active textView
        if let activeTextView = view.firstResponder {
            let visibleRect = scrollViewScroll.convert(activeTextView.frame, from: activeTextView.superview)
            scrollViewScroll.scrollRectToVisible(visibleRect, animated: true)
        }
    }


    @objc func keyboardWillHide(_ notification: Notification) {
        scrollViewScroll.contentInset = .zero
        scrollViewScroll.scrollIndicatorInsets = .zero
    }
   
    @objc func dismissKeyboard() {
         view.endEditing(true)
    }
    func navigationProcess(){
        let titleLabel = UILabel()
        titleLabel.text = "Step 2 of 2 (Optional)"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center

        navigationItem.titleView = titleLabel
    }
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if scrollView == bonusQuestionCV {
            let pageIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.width))
            pageControllerForBonusQuestionCv.currentPage = pageIndex
            bonusQuestionCurrentAndTotalCount.text = "(\(pageIndex + 1)/\(bonusQuestion.count))"
        }
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
        cell.tickImage.tintColor = isSelected ? color : UIColor.darkGray
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
            let width = ( bonusQuestionCV.frame.size.width - 10)
            let height = ( bonusQuestionCV.frame.size.height)
            return CGSize(width: width, height: height)
        }else{
            let width = (sharePhotosCV.frame.size.width - 10) / 3
            let height = (sharePhotosCV.frame.size.height - 10)
            return CGSize(width: width, height: height)
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == bonusQuestionCV{
            return bonusQuestion.count
        }else{
            return 5
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == bonusQuestionCV{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BonusQuestionCVC", for: indexPath)as! BonusQuestionCVC
            let data = bonusQuestion[indexPath.row]
            cell.questionTitle.text = "\(indexPath.row + 1). \(data)"
            cell.onRatingSelected = { [weak self] selectedRating in
                self?.selectedRatings[indexPath.row] = selectedRating
                print("Ratings so far: \(self?.selectedRatings ?? [])")
            }
            return cell
        }else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShareImageCVC", for: indexPath)as! ShareImageCVC
            if indexPath.item < selectedImages.count {
                cell.sharedImage.image = selectedImages[indexPath.item]
                cell.selectImageButton.isHidden = true
            } else {
                cell.sharedImage.image = nil
                cell.selectImageButton.isHidden = false
                cell.selectImageButton.setImage(UIImage(named: "plus"), for: .normal)
            }
            
            cell.selectImageButton.tag = indexPath.item
            cell.selectImageButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
            return cell
        }
    }
    @objc func openImagePicker() {
        guard selectedImages.count < 5 else { return }
        var config = PHPickerConfiguration()
        config.selectionLimit = 5
        config.filter = .images
        
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
}
extension UserFeedBackStepTwoVC: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

     
        let remainingSlots = 5 - selectedImages.count
        let newResults = Array(results.prefix(remainingSlots))

        let group = DispatchGroup()

        for result in newResults {
            group.enter()
            result.itemProvider.loadObject(ofClass: UIImage.self) { (object, error) in
                if let image = object as? UIImage {
                    self.selectedImages.append(image)
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            self.sharePhotosCV.reloadData()
        }
    }

}

extension UIView {
    var firstResponder: UIView? {
        if self.isFirstResponder { return self }
        for subview in self.subviews {
            if let responder = subview.firstResponder {
                return responder
            }
        }
        return nil
    }
}
