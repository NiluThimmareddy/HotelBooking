//
//  FilterOptionsViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 17/06/25.
//

import UIKit

class FilterOptionsViewController: UIViewController {
 
    @IBOutlet var PropertyTypeButtons: [UIButton]!
    @IBOutlet var ReviewScoreButtons: [UIButton]!
    @IBOutlet var starRatingButtons: [UIButton]!
    @IBOutlet var propertyFacilitiesButtons: [UIButton]!
    @IBOutlet var brandButtons: [UIButton]!
    @IBOutlet var propertyFacilitescheckboxButton: [UIButton]!
    @IBOutlet var roomFacilitescheckboxButton: [UIButton]!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var dismissButton: UIButton!
    
    var selectedOptionsList : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bottomView.addTopShadow()
    }
    
    func setUpUI(){
        for button in PropertyTypeButtons{
            button.isSelected = false
            button.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
        for button in brandButtons{
            button.isSelected = false
            button.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
        for button in  propertyFacilitiesButtons{
            button.isSelected = false
            button.borderColor = .black
            button.borderWidth = 1
            button.titleLabel?.textColor = .black
        }
        
        for button in propertyFacilitescheckboxButton{
            button.isSelected = false
            button.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
        for button in roomFacilitescheckboxButton{
            button.isSelected = false
            button.setImage(UIImage(systemName: "square"), for: .normal)
        }
        
        
        for button in starRatingButtons{
            button.isSelected = false
            button.borderColor = .black
            button.borderWidth = 1
            button.titleLabel?.textColor = .black
            
        }
        
        for button in ReviewScoreButtons {
               button.isSelected = false
            button.borderWidth = 0.5
            button.borderColor = .black
           }
        
        
        for button in  propertyFacilitiesButtons{
            button.isSelected = false
            button.borderColor = .black
            button.borderWidth = 1
            button.titleLabel?.textColor = .black
            
        }
    }
    
    @IBAction func ScoreCheckboxTapped(_ sender: UIButton) {
        sender.isSelected.toggle()
 
        let imageName = sender.isSelected ? "checkmark.square.fill" : "square"
        sender.setImage(UIImage(systemName: imageName)?.withRenderingMode(.alwaysOriginal).withTintColor(UIColor(named: "defaultColor") ?? .blue), for: .normal)
        
        sender.setTitleColor(.black, for: .normal)
        
        if let imageView = sender.imageView {
            imageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
            imageView.tintColor = .systemGreen
            UIView.animate(
                withDuration: 0.3,
                delay: 0,
                usingSpringWithDamping: 0.4,
                initialSpringVelocity: 0.6,
                options: .curveEaseOut,
                animations: {
                    imageView.transform = CGAffineTransform.identity
                },
                completion: nil
            )
        }
 
        if let title = sender.titleLabel?.text {
            if sender.isSelected {
                selectedOptionsList.append(title)
            } else {
                selectedOptionsList.removeAll { $0 == title }
            }
        }
 
        print("Selected options: \(selectedOptionsList)")
    }
 
    
    @IBAction func starRatingButtonAction(_ sender: UIButton) {
        sender.isSelected.toggle()
        
        let borderwith = sender.isSelected ? 2 : 1
        let maincolor : UIColor = UIColor(named: "defaultColor") ?? .lightGray
        let bordercolor : UIColor = sender.isSelected ?   maincolor : .lightGray
        
        sender.borderWidth = CGFloat(borderwith)
        sender.borderColor = bordercolor
        sender.tintColor = sender.isSelected ? maincolor : .gray
        sender.titleLabel?.textColor = sender.isSelected ? maincolor : .gray
       
    }
    
    @IBAction func reviewScoreButtonAction(_ sender: UIButton) {
        
        for button in ReviewScoreButtons {
            button.isSelected = false
            button.borderWidth = 0.5
            button.borderColor = .lightGray
            button.tintColor = .black
        }
        
        sender.isSelected = true
        sender.borderWidth = 1
        sender.borderColor = UIColor(named: "defaultColor") ?? .blue
        sender.tintColor = UIColor(named: "defaultColor") ?? .blue
    }
    
    @IBAction func PropertyFacilitiesButtonAction(_ sender: UIButton) {
        
        sender.isSelected.toggle()
        
        let borderwith = sender.isSelected ? 2 : 1
        let maincolor : UIColor = UIColor(named: "defaultColor") ?? .lightGray
        let bordercolor : UIColor = sender.isSelected ?   maincolor : .lightGray
        
        sender.borderWidth = CGFloat(borderwith)
        sender.borderColor = bordercolor
        sender.tintColor = sender.isSelected ? maincolor : .gray
        sender.titleLabel?.textColor = sender.isSelected ? maincolor : .gray
    }
    
    
    
    @IBAction func clearButtonAction(_ sender: UIButton) {
        
        setUpUI()
    }
    
    
    @IBAction func dismissbuttonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func seeResultButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
}
