//
//  GuestAndRoomsVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 09/06/25.
//

import UIKit

class GuestAndRoomsVC: UIViewController {
    
      
    @IBOutlet weak var selectRoomsTitleTop: NSLayoutConstraint!
    @IBOutlet weak var simpleTopView: UIView!
    @IBOutlet weak var xmarkCloseButton: UIButton!
    @IBOutlet weak var agePickerViewCancelButton: UIButton!
    @IBOutlet weak var agePickerViewOkButton: UIButton!
    @IBOutlet weak var agePickerView: UIPickerView!
    @IBOutlet weak var popUpCloseButton: UIButton!
    @IBOutlet weak var popUpView: UIView!
    @IBOutlet weak var scrollViewContentViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeightCons: NSLayoutConstraint!
    @IBOutlet weak var childrenGuestTV: UITableView!
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrollViewScroll: UIScrollView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var backViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var TravellingWithPetsSwitch: UISwitch!
    @IBOutlet weak var childrenBackView: UIView!
    @IBOutlet weak var adultsBackView: UIView!
    @IBOutlet weak var roomsBackView: UIView!
    @IBOutlet weak var adultCountTF: UITextField!
    @IBOutlet weak var childrensCountTF: UITextField!
    @IBOutlet weak var childrensPlusButton: UIButton!
    @IBOutlet weak var childrensMinusButton: UIButton!
    @IBOutlet weak var adultPlusButton: UIButton!
    @IBOutlet weak var adultMinusButton: UIButton!
    @IBOutlet weak var roomsCountTF: UITextField!
    @IBOutlet weak var roomsPlusButton: UIButton!
    @IBOutlet weak var roomsMinusButton: UIButton!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var travellingWithPetLbl: UITextView!
    
    var childrenAges: [String] = []
    var selectedPickerRow: Int?
    var selectedChildRowIndex: Int?
    var  childrenAge = ["select","< 1 year old","1 year old","2 years old","3 years old","4 years old","5 years old","6 years old","7 years old","8 years old","9 years old","10 years old","11 years old","12 years old","13 years old","14 years old","15 years old","16 years old","17 years old"]

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpView.isHidden = true
        alphaView.alpha = 0.1
        popUpCloseButton.alpha = 0.1
        TravellingWithPetsSwitch.isOn = false
        //        backView.BackViewShadowAppyManually(cornerRadius: 20)
        setupAssistanceAnimalText()
        roomsCountTF.text = "1" //default
        adultCountTF.text = "1" //default
        childrensCountTF.text = "0" //default
        
        roomsBackView.layer.borderWidth = 2
        roomsBackView.layer.borderColor = UIColor.lightGray.cgColor
        roomsBackView.layer.cornerRadius = 5
        
        adultsBackView.layer.borderWidth = 2
        adultsBackView.layer.borderColor = UIColor.lightGray.cgColor
        adultsBackView.layer.cornerRadius = 5
        
        childrenBackView.layer.borderWidth = 2
        childrenBackView.layer.borderColor = UIColor.lightGray.cgColor
        childrenBackView.layer.cornerRadius = 5
        print("backViewHeightConstraint is nil? \(backViewHeightConstraint == nil)")
        print("backViewTopConstraint is nil? \(backViewTopConstraint == nil)")
        
        updateChildConstraintIfNeeded()
        childrenGuestTV.register(UINib(nibName: "ChildrenGuestTVC", bundle: nil), forCellReuseIdentifier: "ChildrenGuestTVC")
        
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateDynamicHeights()
    }

    func updateDynamicHeights() {
           guard let count = Int(childrensCountTF.text ?? "0") else {
               print("Invalid children count")
               return
           }

           let baseHeight: CGFloat = 386
           let perChildHeight: CGFloat = 100

           // Update scroll content height
           scrollViewContentViewHeightCons.constant = baseHeight + (CGFloat(count) * perChildHeight)

           // Update table view height as well
           tableViewHeightCons.constant = CGFloat(count) * perChildHeight

         
               self.view.layoutIfNeeded()
           
       }

    func updateChildConstraintIfNeeded() {
        guard let topConstraint = backViewTopConstraint else {
            print("Top constraint is nil")
            return
        }

        guard let count = Int(childrensCountTF.text ?? "") else {
            print("Invalid children count")
            return
        }

        switch count {
        case 0:
            let screenHeight = UIScreen.main.bounds.height

            if UIDevice.current.userInterfaceIdiom == .phone && (screenHeight == 568 || screenHeight == 667) {
                print("Likely an iPhone SE")
                topConstraint.constant = 200
                alphaView.isHidden = false
                childrenGuestTV.isHidden = true
                selectRoomsTitleTop.constant = 30
                xmarkCloseButton.isHidden = true
                simpleTopView.isHidden = false
                
            }else if UIDevice.current.userInterfaceIdiom == .pad {
                topConstraint.constant = 250
                alphaView.isHidden = false
                childrenGuestTV.isHidden = true
                selectRoomsTitleTop.constant = 30
                xmarkCloseButton.isHidden = true
                simpleTopView.isHidden = false
            }else{
                topConstraint.constant = 250
                alphaView.isHidden = false
                childrenGuestTV.isHidden = true
                selectRoomsTitleTop.constant = 30
                xmarkCloseButton.isHidden = true
                simpleTopView.isHidden = false
            }
        case 1:
            topConstraint.constant = 0
            alphaView.isHidden = true
            childrenGuestTV.isHidden = false
            selectRoomsTitleTop.constant = 50
            xmarkCloseButton.isHidden = false
            simpleTopView.isHidden = true
            updateDynamicHeights()
        default:
            print("Unhandled count")
        }

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }


    @IBAction func agePickerViewCancelButton(_ sender: Any) {
        popUpView.isHidden = true
    }
    
    @IBAction func agePickerViewOkButton(_ sender: Any) {
        guard let row = selectedPickerRow,
              let index = selectedChildRowIndex else { return }
        
        childrenAges[index] = childrenAge[row]
        
        childrenGuestTV.reloadRows(at: [IndexPath(row: index, section: 0)], with: .none)
        
        popUpView.isHidden = true
        alphaView.alpha = 0
    }
    


    @IBAction func xmarkCloseButton(_ sender: Any) {
        dismiss(animated: true)
    }
    @IBAction func popUpCloseButton(_ sender: Any) {
        popUpView.isHidden = true
    }
    @IBAction func TravellingWithPetsSwitchAct(_ sender: UISwitch) {
        if sender.isOn {
            print("Travelling with pets enabled")
        } else {
            print("Travelling with pets disabled")
        }
    }
    @IBAction func roomsMinusButton(_ sender: Any) {
        updateCount(for: roomsCountTF, increase: false, minValue: 1)

    }
    
    @IBAction func roomsPlusButton(_ sender: Any) {
        updateCount(for: roomsCountTF, increase: true)
    }
    
    @IBAction func adultMinusButton(_ sender: Any) {
        updateCount(for: adultCountTF, increase: false, minValue: 1)

    }
    
    @IBAction func adultPlusButton(_ sender: Any) {
        updateCount(for: adultCountTF, increase: true)
    }
    
    @IBAction func childrensMinusButton(_ sender: Any) {
        updateCount(for: childrensCountTF, increase: false, minValue: 0)
        DispatchQueue.main.async {
            self.updateChildConstraintIfNeeded()
        }
        
        
    }
    
    @IBAction func childrensPlusButton(_ sender: Any) {
        updateCount(for: childrensCountTF, increase: true)
        updateChildConstraintIfNeeded()
    }
    
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func setupAssistanceAnimalText() {
        let text = "Assistance animals aren't considered pets. Read more about travelling with assistance animals"
        let linkText = "Read more about travelling with assistance animals"
        let url = URL(string: "https://your-url-here.com")!
        
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.darkGray, range: NSRange(location: 0, length: text.count))
        
        if let linkRange = text.range(of: linkText) {
            let nsRange = NSRange(linkRange, in: text)
            attributedString.addAttribute(.link, value: url, range: nsRange)
            attributedString.addAttribute(.foregroundColor, value: UIColor.systemBlue, range: nsRange)
        }
        
        travellingWithPetLbl.attributedText = attributedString
        travellingWithPetLbl.isEditable = false
        travellingWithPetLbl.isScrollEnabled = false
        travellingWithPetLbl.dataDetectorTypes = .link
        travellingWithPetLbl.textAlignment = .left
        travellingWithPetLbl.backgroundColor = .clear
    }
    private func updateCount(for textField: UITextField, increase: Bool, minValue: Int = 0, maxValue: Int = 10) {
        let current = Int(textField.text ?? "") ?? minValue
        var newValue = increase ? current + 1 : current - 1
        newValue = Swift.max(minValue, Swift.min(newValue, maxValue))
        textField.text = "\(newValue)"
        
        if textField == childrensCountTF {
            syncChildrenAgeArray(to: newValue)
            childrenGuestTV.reloadData()
            updateDynamicHeights()
        }
    }

    private func syncChildrenAgeArray(to newCount: Int) {
        if childrenAges.count < newCount {
            for _ in childrenAges.count..<newCount {
                childrenAges.append("select")
            }
        } else if childrenAges.count > newCount {
            childrenAges.removeLast(childrenAges.count - newCount)
        }
    }
}


extension GuestAndRoomsVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return childrenAges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenGuestTVC")as! ChildrenGuestTVC
        let count = childrenAges[indexPath.row]
        cell.childCountLbl.text = "Child \(indexPath.row + 1)"
        cell.selectAgeButton.setTitle(count, for: .normal)
            cell.onSelectAgeTapped = { [weak self] in
                self?.selectedChildRowIndex = indexPath.row
                self?.popUpView.isHidden = false
            }
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedChildRowIndex = indexPath.row
        selectedPickerRow = childrenAge.firstIndex(of: childrenAges[indexPath.row]) ?? 0
        agePickerView.selectRow(selectedPickerRow ?? 0, inComponent: 0, animated: false)
        
        popUpView.isHidden = false
        alphaView.alpha = 0.5
    }
}

extension GuestAndRoomsVC: UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return childrenAge.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return childrenAge[row]
        }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPickerRow = row
    }
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
            return 50
        }
}
