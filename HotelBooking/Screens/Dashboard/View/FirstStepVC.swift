//
//  FirstStepVC.swift
//  HotelBooking
//
//  Created by toqsoft on 23/06/25.
//

import UIKit

class FirstStepVC: UIViewController {

    @IBOutlet weak var roomNameLabel: UILabel!
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var roomCountLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!
    
    var roomCount = 1
    let roomPrice = 120.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateRoomDetails()
    }
    
    func updateRoomDetails() {
        roomCountLabel.text = "\(roomCount)"
        let totalPrice = Int(roomPrice) * roomCount
        priceLabel.text = "$ \(totalPrice)"

    }
    
    @IBAction func dismissButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func minusButtonAction(_ sender: Any) {
        if roomCount > 1 {
            roomCount -= 1
            updateRoomDetails()
        }
    }
    
    @IBAction func plusButtonAction(_ sender: Any) {
        roomCount += 1
        updateRoomDetails()
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SecondStepVC") as? SecondStepVC else { return }

        if let sheet = controller.sheetPresentationController {
            let heightFactor: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.5 : 0.6

            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * heightFactor
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20

            if UIDevice.current.userInterfaceIdiom == .pad {
                sheet.largestUndimmedDetentIdentifier = .medium
                controller.preferredContentSize = CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * heightFactor
                )
            }
        }

        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }
}
