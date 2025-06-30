//
//  ThirdStepVC.swift
//  HotelBooking
//
//  Created by toqsoft on 23/06/25.
//

import UIKit

class ThirdStepVC: UIViewController {

    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var bedCountLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    
    var bedCount = 1
    let bedPrice = 20
    let taxPercentage: Double = 0.05
    
    weak var delegate: ThirdStepVCDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        bedCountLabel.text = "\(bedCount)"
        
        let totalPrice = bedPrice * bedCount
        let taxAmount = Double(totalPrice) * taxPercentage
        
        priceLabel.text = "$ \(totalPrice) • 1 room"
        taxLabel.text = "$ \(Int(taxAmount)) taxes & fees"
        
        minusButton.isEnabled = bedCount > 1
        plusButton.isEnabled = bedCount < 3
    }

    @IBAction func minusButtonAction(_ sender: Any) {
        if bedCount > 1 {
            bedCount -= 1
            updateUI()
        }
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        bedCount += 1
        updateUI()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func confirmButtonAction(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: {
            self.delegate?.navigateToBookingOverview()
        })
    }
}

