//
//  AssistanceAnimalPolicyVC.swift
//  HotelBooking
//
//  Created by toqsoft on 06/06/25.
//

import UIKit

class AssistanceAnimalPolicyVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        let text = """
        Certified assistance animals are highly trained disability support aids that play an essential role in helping individuals with disabilities to engage in daily tasks safely and confidently.

        In many countries, travellers with an assistance animal are entitled to book any accommodation without facing additional fees or conditions even if pets aren’t allowed. Legal requirements on assistance animals vary based on location, so before travelling, study the local laws.
        """

        let attributedText = NSMutableAttributedString(string: text)

        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.paragraphSpacing = 2
        paragraphStyle.lineSpacing = 1

        let fullRange = NSRange(location: 0, length: attributedText.length)
        attributedText.addAttributes([
            .font: UIFont.systemFont(ofSize: 12),
            .paragraphStyle: paragraphStyle,
            .foregroundColor: UIColor.label
        ], range: fullRange)

        let linkText = "Certified assistance animals"
        if let linkRange = text.range(of: linkText) {
            let nsRange = NSRange(linkRange, in: text)

            attributedText.addAttributes([
                .foregroundColor: UIColor.systemBlue,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .link: URL(string: "action://certifiedAssistanceAnimals")!
            ], range: nsRange)
        }

        textView.attributedText = attributedText

        textView.isEditable = false
        textView.isSelectable = true
        textView.delegate = self

        textView.textContainerInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        textView.linkTextAttributes = [
            .foregroundColor: UIColor.systemBlue,
            .underlineStyle: NSUnderlineStyle.single.rawValue
        ]
    }

    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {

        if URL.scheme == "action", URL.host == "certifiedAssistanceAnimals" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let targetVC = storyboard.instantiateViewController(withIdentifier: "HomePageViewController") as? HomePageViewController {
                targetVC.modalPresentationStyle = .fullScreen
                present(targetVC, animated: true)
            }
            return false
        }

        return true
    }
}

