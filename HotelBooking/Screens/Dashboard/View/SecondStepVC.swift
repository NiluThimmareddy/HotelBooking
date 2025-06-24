//
//  SecondStepVC.swift
//  HotelBooking
//
//  Created by toqsoft on 23/06/25.
//

import UIKit

enum BedPreference {
    case noPreference, extraLarge, large
}

class SecondStepVC: UIViewController {

    @IBOutlet weak var noPreferenceButton: UIButton!
    @IBOutlet weak var extraLargeBedButton: UIButton!
    @IBOutlet weak var largeBedButton: UIButton!
    @IBOutlet weak var proceLabel: UILabel!
    @IBOutlet weak var taxLabel: UILabel!

    var selectedPreference: BedPreference?

    override func viewDidLoad() {
        super.viewDidLoad()
        updateBedPreferenceUI()
    }

    func updateBedPreferenceUI() {
        let selectedImage = UIImage(systemName: "record.circle.fill")?.withRenderingMode(.alwaysTemplate)
        let unselectedImage = UIImage(systemName: "circle")?.withRenderingMode(.alwaysTemplate)
        
        let selectedColor = UIColor(hex: "#003B95")
        let unselectedColor = UIColor.black

        noPreferenceButton.setImage(selectedPreference == .noPreference ? selectedImage : unselectedImage, for: .normal)
        noPreferenceButton.tintColor = selectedPreference == .noPreference ? selectedColor : unselectedColor

        extraLargeBedButton.setImage(selectedPreference == .extraLarge ? selectedImage : unselectedImage, for: .normal)
        extraLargeBedButton.tintColor = selectedPreference == .extraLarge ? selectedColor : unselectedColor

        largeBedButton.setImage(selectedPreference == .large ? selectedImage : unselectedImage, for: .normal)
        largeBedButton.tintColor = selectedPreference == .large ? selectedColor : unselectedColor
    }

    @IBAction func noPreferenceButtonAction(_ sender: Any) {
        selectedPreference = .noPreference
        updateBedPreferenceUI()
    }

    @IBAction func extraLargeButtonAction(_ sender: Any) {
        selectedPreference = .extraLarge
        updateBedPreferenceUI()
    }

    @IBAction func largeBedButtonAction(_ sender: Any) {
        selectedPreference = .large
        updateBedPreferenceUI()
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

    @IBAction func nextStepButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "ThirdStepVC") as? ThirdStepVC else { return }

        if let sheet = controller.sheetPresentationController {
            let heightFactor: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.43 : 0.6

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

