//
//  VerificationCodeVC.swift
//  HotelBooking
//
//  Created by toqsoft on 15/07/25.
//

import UIKit

class VerificationCodeVC: UIViewController {
    
    @IBOutlet weak var verificationEmailLabel: UILabel!
    @IBOutlet weak var codeOneTF: UITextField!
    @IBOutlet weak var codeTwoTF: UITextField!
    @IBOutlet weak var codeThreeTF: UITextField!
    @IBOutlet weak var codeFourTF: UITextField!
    @IBOutlet weak var confirmCodeButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var resendCodeButton: UIButton!
    
    var countdownTimer: Timer?
    var totalTime = 60
    var email: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        codeOneTF.becomeFirstResponder()
    }

    @IBAction func confirmCodeButtonAction(_ sender: Any) {
        let storyboard = storyboard?.instantiateViewController(withIdentifier: "NewPasswordVC") as! NewPasswordVC
        storyboard.modalPresentationStyle = .fullScreen
        present(storyboard, animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resendCodeButtonAction(_ sender: Any) {
        totalTime = 60
        resendCodeButton.isEnabled = false
        resendCodeButton.alpha = 0.5
        startTimer()
    }
    
}

extension VerificationCodeVC : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if string.isEmpty {
            moveToPreviousTextField(from: textField)
            textField.text = ""
            return false
        }
        
        let allowedCharacters = CharacterSet.decimalDigits
        if string.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            return false
        }
        
        if let currentText = textField.text, currentText.count == 0 {
            textField.text = string
            moveToNextTextField(from: textField)
            return false
        }
        return false
    }

    
    func moveToNextTextField(from textField: UITextField) {
        switch textField {
        case codeOneTF:
            codeTwoTF.becomeFirstResponder()
        case codeTwoTF:
            codeThreeTF.becomeFirstResponder()
        case codeThreeTF:
            codeFourTF.becomeFirstResponder()
        case codeFourTF:
            codeFourTF.resignFirstResponder()
        default:
            break
        }
    }
    
    func moveToPreviousTextField(from textField: UITextField) {
        switch textField {
        case codeFourTF:
            codeThreeTF.becomeFirstResponder()
        case codeThreeTF:
            codeTwoTF.becomeFirstResponder()
        case codeTwoTF:
            codeOneTF.becomeFirstResponder()
        case codeOneTF:
            codeOneTF.resignFirstResponder()
        default:
            break
        }
    }
}

extension VerificationCodeVC {
    func setUpUI() {
        let displayEmail = email ?? "your email"
        
        verificationEmailLabel.setHighlightedText(
            fullText: "Verification code sent to \(displayEmail)",
            highlightText: displayEmail,
            normalFont: .systemFont(ofSize: 14),
            highlightFont: .boldSystemFont(ofSize: 18),
            normalColor: .darkGray,
            highlightColor: UIColor(hex: "#003B95")
        )
        
        [codeOneTF, codeTwoTF, codeThreeTF, codeFourTF].forEach {
            $0?.delegate = self
            $0?.keyboardType = .numberPad
            $0?.textAlignment = .center
        }
                
        resendCodeButton.isEnabled = false
        resendCodeButton.alpha = 0.5
        totalTime = 60
        startTimer()
    }
    
    func startTimer() {
        timeLabel.text = formatTime(totalTime)
        
        countdownTimer?.invalidate()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.totalTime -= 1
            self.timeLabel.text = self.formatTime(self.totalTime)
            
            if self.totalTime <= 0 {
                self.countdownTimer?.invalidate()
                self.timeLabel.text = "0:00"
                self.resendCodeButton.isEnabled = true
                self.resendCodeButton.alpha = 1.0
            }
        }
    }
    
    func formatTime(_ totalSeconds: Int) -> String {
        let minutes = totalSeconds / 60
        let seconds = totalSeconds % 60
        return String(format: "%d:%02d", minutes, seconds)
    }
}
