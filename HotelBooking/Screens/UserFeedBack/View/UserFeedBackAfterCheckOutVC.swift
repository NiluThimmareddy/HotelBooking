//
//  UserFeedBackAfterCheckOutVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 13/06/25.
//

import UIKit


class UserFeedBackAfterCheckOutVC: UIViewController {
    
    @IBOutlet weak var dontWorryLbl: UILabel!
    @IBOutlet weak var tellUsAboutYourTripLbl: UILabel!
    @IBOutlet weak var howWasTheLocationLbl: UILabel!
    @IBOutlet weak var wasItGoodValueForMoneyLbl: UILabel!
    @IBOutlet weak var wasItComfortableLbl: UILabel!
    @IBOutlet weak var wasItCleanLbl: UILabel!
    @IBOutlet weak var howWereTheFacilitiesLbl: UILabel!
    @IBOutlet weak var howWereTheStaffLbl: UILabel!
    @IBOutlet weak var experienceLbl: UILabel!
    @IBOutlet weak var exceptionalLbl: UILabel!
    @IBOutlet weak var badLbl: UILabel!
    @IBOutlet weak var plesantEmojiImage: UIImageView!
    @IBOutlet weak var howWasYourStayLbl: UILabel!
    @IBOutlet weak var raterYourStayLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var howManyDays: UILabel!
    @IBOutlet weak var hotelName: UILabel!
    @IBOutlet weak var hotelImage: UIImageView!
    
    @IBOutlet weak var oneToTenTenButton: UIButton!
    @IBOutlet weak var oneToTenNineButton: UIButton!
    @IBOutlet weak var oneToTenEightButton: UIButton!
    @IBOutlet weak var oneToTenSevenButton: UIButton!
    @IBOutlet weak var oneToTenSixButton: UIButton!
    @IBOutlet weak var oneToTenFiveButton: UIButton!
    @IBOutlet weak var oneToTenFourButton: UIButton!
    @IBOutlet weak var oneToTenThreeButton: UIButton!
    @IBOutlet weak var oneToTenTwoButton: UIButton!
    @IBOutlet weak var oneToTenOneButton: UIButton!
    @IBOutlet weak var plesantLbl: UILabel!
    @IBOutlet weak var oneToTenRatingBackView: UIView!
    @IBOutlet weak var oneToTenRatingCV: UICollectionView!
    @IBOutlet weak var locationBackView: UIView!
    @IBOutlet weak var moneyBackView: UIView!
    @IBOutlet weak var comfortableBackView: UIView!
    @IBOutlet weak var cleanBackView: UIView!
    @IBOutlet weak var facilitiesBackView: UIView!
    @IBOutlet weak var staffBackView: UIView!
    
    @IBOutlet weak var locationFifthButton: UIButton!
    @IBOutlet weak var locationFourthButton: UIButton!
    @IBOutlet weak var locationThirdButton: UIButton!
    @IBOutlet weak var locationSecondButton: UIButton!
    @IBOutlet weak var locationFirstButton: UIButton!
    //    ....
    @IBOutlet weak var moneyFifthButton: UIButton!
    @IBOutlet weak var moneyFourthButton: UIButton!
    @IBOutlet weak var moneyThirdButton: UIButton!
    @IBOutlet weak var moneySecondButton: UIButton!
    @IBOutlet weak var moneyFirstButton: UIButton!
    //    ....
    @IBOutlet weak var comfortableFifthButton: UIButton!
    @IBOutlet weak var comfortableFourthButton: UIButton!
    @IBOutlet weak var comfortableThirdButton: UIButton!
    @IBOutlet weak var comfortableSecondButton: UIButton!
    @IBOutlet weak var comfortableFirstButton: UIButton!
//    ...
    @IBOutlet weak var cleanFifthButton: UIButton!
    @IBOutlet weak var cleanFourthButton: UIButton!
    @IBOutlet weak var cleanThirdButton: UIButton!
    @IBOutlet weak var cleanSecondButton: UIButton!
    @IBOutlet weak var cleanFirstButton: UIButton!
//    ....
    @IBOutlet weak var facilitiesFifthButton: UIButton!
    @IBOutlet weak var facilitiesFourthButton: UIButton!
    @IBOutlet weak var facilitiesThirdButton: UIButton!
    @IBOutlet weak var facilitiesSecondButton: UIButton!
    @IBOutlet weak var facilitiesFirstButton: UIButton!
//    ....
    @IBOutlet weak var staffFifthButton: UIButton!
    @IBOutlet weak var staffFourthButton: UIButton!
    @IBOutlet weak var staffThirdButton: UIButton!
    @IBOutlet weak var staffSecondButton: UIButton!
    @IBOutlet weak var staffFirstButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var tellUsTripFriendsButton: UIButton!
    @IBOutlet weak var tellUsTripBusinessButton: UIButton!
    @IBOutlet weak var tellUsTripFriendsTV: UITableView!
    @IBOutlet weak var tellUsTripBusinessTV: UITableView!
   
    var selectedRatingIndex: Int?
    let color = UIColor(named: "defaultColor")
    var businessData = ["Business","Leisure","Others"]
    var travellerData = ["Couple","Solo Traveller","Family","Group of friends"]
    var plesantData = ["Bad","Very poor","Poor", "Disappointing","Passable","Pleasant","Good","Very good","Superb","Exceptional"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tellUsTripFriendsTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        tellUsTripBusinessTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        oneToTenRatingCV.register(UINib(nibName: "OneToTenRatingCVC", bundle: nil), forCellWithReuseIdentifier: "OneToTenRatingCVC")
        tellUsTripBusinessTV.isHidden = true
        tellUsTripFriendsTV.isHidden = true
        
        continueButton.layer.cornerRadius = 5
        finishButton.layer.cornerRadius = 5
        finishButton.layer.borderWidth = 2
        finishButton.layer.borderColor = color?.cgColor
        buttonUpdateHilighting()
        backView()
        selectedRatingIndex = 5
        oneToTenRatingCV.reloadData()
        navigationProcess()
        applyFontText()
    }
    func applyFontText(){
        hotelName.font = .poppinsBold(25)
        howManyDays.font = .poppinsMedium(12)
        dateLbl.font = .poppinsMedium(12)
        raterYourStayLbl.font = .poppinsBold(16)
        howWasYourStayLbl.font = .poppinsBold(14)
        plesantLbl.font = .poppinsBold(14)
        badLbl.font = .poppinsBold(14)
        exceptionalLbl.font = .poppinsBold(14)
        experienceLbl.font = .poppinsBold(16)
        howWereTheStaffLbl.font = .poppinsBold(14)
        howWereTheFacilitiesLbl.font = .poppinsBold(14)
        wasItCleanLbl.font = .poppinsBold(14)
        wasItComfortableLbl.font = .poppinsBold(14)
        wasItComfortableLbl.font = .poppinsBold(14)
        wasItGoodValueForMoneyLbl.font = .poppinsBold(14)
        howWasTheLocationLbl.font = .poppinsBold(14)
        tellUsAboutYourTripLbl.font = .poppinsBold(14)
        dontWorryLbl.font = .poppinsMedium(12)
        let business = NSAttributedString(
            string: "Business",
            attributes: [.font: UIFont.poppinsMedium(14), .foregroundColor: UIColor.darkGray]
        )
        tellUsTripBusinessButton.setAttributedTitle(business, for: .normal)
        let friends = NSAttributedString(
            string: "Group of friends",
            attributes: [.font: UIFont.poppinsMedium(14), .foregroundColor:  UIColor.darkGray]
        )
        tellUsTripFriendsButton.setAttributedTitle(friends, for: .normal)
        let continues = NSAttributedString(
            string: "Continue",
            attributes: [.font: UIFont.poppinsBold(16), .foregroundColor: UIColor.white ]
        )
        continueButton.setAttributedTitle(continues, for: .normal)
        let finish = NSAttributedString(
            string: "Finish",
            attributes: [.font: UIFont.poppinsBold(16), .foregroundColor: color ?? UIColor.blue ]
        )
        finishButton.setAttributedTitle(finish, for: .normal)
    }
    func backView(){
        styleBackView(oneToTenRatingBackView)
        styleBackView(locationBackView)
        styleBackView(moneyBackView)
        styleBackView(comfortableBackView)
        styleBackView(cleanBackView)
        styleBackView(facilitiesBackView)
        styleBackView(staffBackView)
    }
    func styleBackView(_ view: UIView) {
        view.layer.cornerRadius = 10
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.systemGray6.cgColor
        view.clipsToBounds = true
    }
    func navigationProcess(){
        let titleLabel = UILabel()
        titleLabel.text = "Step 1 of 2"
        titleLabel.textColor = .white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textAlignment = .center

        navigationItem.titleView = titleLabel
    }
    func updateRatingButtons(selectedRating: Int, buttons: [UIButton]) {
        for button in buttons {
            if button.tag == selectedRating {
                button.backgroundColor = color
                button.setTitleColor(.white, for: .normal)
                button.tintColor = .white
            } else {
                button.backgroundColor = .white
                button.setTitleColor(.lightGray, for: .normal)
                button.tintColor = .lightGray
            }
        }
    }
    func buttonUpdateHilighting(){
        updateRatingButtons(selectedRating: 2, buttons: [staffFirstButton, staffSecondButton, staffThirdButton, staffFourthButton, staffFifthButton])
        updateRatingButtons(selectedRating: 3, buttons: [facilitiesFirstButton, facilitiesSecondButton, facilitiesThirdButton, facilitiesFourthButton, facilitiesFifthButton])
        updateRatingButtons(selectedRating: 3, buttons: [cleanFirstButton, cleanSecondButton, cleanThirdButton, cleanFourthButton, cleanFifthButton])
        updateRatingButtons(selectedRating: 3, buttons: [comfortableFirstButton, comfortableSecondButton, comfortableThirdButton, comfortableFourthButton, comfortableFifthButton])
        updateRatingButtons(selectedRating: 3, buttons: [moneyFirstButton, moneySecondButton, moneyThirdButton, moneyFourthButton, moneyFifthButton])
        updateRatingButtons(selectedRating: 3, buttons: [locationFirstButton, locationSecondButton, locationThirdButton, locationFourthButton, locationFifthButton])
        updateRatingUI(selected: 6)
    }
    func updateRatingUI(selected: Int) {
        let buttons = [
            oneToTenOneButton, oneToTenTwoButton, oneToTenThreeButton,
            oneToTenFourButton, oneToTenFiveButton, oneToTenSixButton,
            oneToTenSevenButton, oneToTenEightButton, oneToTenNineButton,
            oneToTenTenButton
        ]
        
        for (index, button) in buttons.enumerated() {
            if index + 1 == selected {
                button?.backgroundColor = color
                button?.tintColor = .white
            } else {
                button?.backgroundColor = UIColor.white
                button?.tintColor = .lightGray
            }
        }
    }

    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func oneToTenRatingTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        print("Selected Rating: \(selectedRating)")
        
        let index = selectedRating - 1  
        
        if index >= 0 && index < plesantData.count {
            plesantLbl.text = plesantData[index]
            updateRatingUI(selected: selectedRating)
        } else {
            print("Invalid rating index")
        }
    }

    @IBAction func staffButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        updateRatingButtons(selectedRating: selectedRating, buttons: [
            staffFirstButton,
            staffSecondButton,
            staffThirdButton,
            staffFourthButton,
            staffFifthButton
        ])
        print("Staff rating: \(selectedRating)")
    }
    @IBAction func facilitiesButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        updateRatingButtons(selectedRating: selectedRating, buttons: [
            facilitiesFirstButton,
            facilitiesSecondButton,
            facilitiesThirdButton,
            facilitiesFourthButton,
            facilitiesFifthButton
        ])
        print("Facilities rating: \(selectedRating)")
    }
    @IBAction func cleanButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        updateRatingButtons(selectedRating: selectedRating, buttons: [
            cleanFirstButton,
            cleanSecondButton,
            cleanThirdButton,
            cleanFourthButton,
            cleanFifthButton
        ])
        print("Clean rating: \(selectedRating)")
    }
    @IBAction func comfortableButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        updateRatingButtons(selectedRating: selectedRating, buttons: [
            comfortableFirstButton,
            comfortableSecondButton,
            comfortableThirdButton,
            comfortableFourthButton,
            comfortableFifthButton
        ])
        print("Comfortable rating: \(selectedRating)")
    }
    @IBAction func moneyButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        updateRatingButtons(selectedRating: selectedRating, buttons: [
            moneyFirstButton,
            moneySecondButton,
            moneyThirdButton,
            moneyFourthButton,
            moneyFifthButton
        ])
        print("Money rating: \(selectedRating)")
    }
    @IBAction func locationButtonTapped(_ sender: UIButton) {
        let selectedRating = sender.tag
        updateRatingButtons(selectedRating: selectedRating, buttons: [
            locationFirstButton,
            locationSecondButton,
            locationThirdButton,
            locationFourthButton,
            locationFifthButton
        ])
        print("Location rating: \(selectedRating)")
    }


    @IBAction func finishButton(_ sender: Any) {
    }
    
    @IBAction func continueButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "UserFeedBack", bundle: nil)
        let controller = storyboard.instantiateViewController(identifier: "UserFeedBackStepTwoVC")as! UserFeedBackStepTwoVC
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(controller, animated: true)
    }
    @IBAction func tellUsTripFriendsButton(_ sender: Any) {
        let friends = NSAttributedString(
            string: "---Select any of these list---",
            attributes: [.font: UIFont.poppinsMedium(14), .foregroundColor:  UIColor.darkGray]
        )
        tellUsTripFriendsButton.setAttributedTitle(friends, for: .normal)
        tellUsTripFriendsTV.isHidden = !tellUsTripFriendsTV.isHidden
        tellUsTripBusinessTV.isHidden = true
    }
    @IBAction func tellUsTripBusinessButton(_ sender: Any) {
        let business = NSAttributedString(
            string: "---Select any of these list---",
            attributes: [.font: UIFont.poppinsMedium(14), .foregroundColor: UIColor.darkGray]
        )
        tellUsTripBusinessButton.setAttributedTitle(business, for: .normal)
        tellUsTripBusinessTV.isHidden = !tellUsTripBusinessTV.isHidden
        tellUsTripFriendsTV.isHidden = true
        
    }
    
}

extension UserFeedBackAfterCheckOutVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tellUsTripFriendsTV{
            return travellerData.count
        }else{
            return businessData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tellUsTripFriendsTV{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserFeedBackAfterCheckOutTVC")as! UserFeedBackAfterCheckOutTVC
            let data = travellerData[indexPath.row]
            cell.titleData.text = data
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserFeedBackAfterCheckOutTVC")as! UserFeedBackAfterCheckOutTVC
            let data = businessData[indexPath.row]
            cell.titleData.text = data
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tellUsTripFriendsTV {
                let data = travellerData[indexPath.row]
                let attributed = NSAttributedString(
                    string: data,
                    attributes: [.font: UIFont.poppinsMedium(14), .foregroundColor: UIColor.darkGray]
                )
                tellUsTripFriendsButton.setAttributedTitle(attributed, for: .normal)
                tellUsTripFriendsTV.isHidden = true
            } else {
                let data = businessData[indexPath.row]
                let attributed = NSAttributedString(
                    string: data,
                    attributes: [.font: UIFont.poppinsMedium(14), .foregroundColor: UIColor.darkGray]
                )
                tellUsTripBusinessButton.setAttributedTitle(attributed, for: .normal)
                tellUsTripBusinessTV.isHidden = true
            }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}


extension UserFeedBackAfterCheckOutVC: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = oneToTenRatingCV.frame.size.width / 10
        let height = oneToTenRatingCV.frame.size.height
        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OneToTenRatingCVC", for: indexPath) as! OneToTenRatingCVC
        
        let ratingValue = indexPath.row + 1
        cell.oneToTenRatingButton.setTitle("\(ratingValue)", for: .normal)
        cell.backView.backgroundColor = (indexPath.item == selectedRatingIndex) ? color : UIColor.white
        cell.oneToTenRatingButton.tintColor = (indexPath.item == selectedRatingIndex) ? UIColor.white : UIColor.lightGray
        plesantLbl.text = plesantData[selectedRatingIndex ?? 0]
        cell.onButtonTapped = { [weak self] in
            print("Selected rating: \(ratingValue)")
            self?.handleRatingSelection(ratingValue)
        }

        return cell
    }

    func handleRatingSelection(_ rating: Int) {
        selectedRatingIndex = rating - 1
        plesantLbl.text = plesantData[selectedRatingIndex ?? 0]
        oneToTenRatingCV.reloadData()
    }
    
}
