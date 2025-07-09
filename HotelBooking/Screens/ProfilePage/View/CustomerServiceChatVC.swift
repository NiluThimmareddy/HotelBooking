//
//  CustomerServiceVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 02/07/25.
//

import UIKit

class CustomerServiceChatVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var inputContainerBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var centreView: UIView!
    @IBOutlet weak var chatTableView: UITableView!
    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var inputContainerView: UIView!

    var chatMessages: [ChatMessage] = []
    let topNameLbl: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.text = "Customer Service Chat"
       label.font = UIFont.poppinsBold(16)
       label.textAlignment = .center
       return label
   }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTableView.register(UINib(nibName: "CustomerServiceChatTVC", bundle: nil), forCellReuseIdentifier: "CustomerServiceChatTVC")
        setupKeyboardObservers()

        let tableTapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tableTapGesture.cancelsTouchesInView = false
        chatTableView.addGestureRecognizer(tableTapGesture)
        navigationItem.titleView = topNameLbl
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDefaultNavigationBarAppearance()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        setupDefaultNavigationBarDisAppearance()
    }
    func setupDefaultNavigationBarAppearance() {
        if let color = UIColor(named: "defaultColor") {
            navigationController?.navigationBar.barTintColor = color
            navigationController?.navigationBar.backgroundColor = color
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
            navigationController?.navigationBar.tintColor = .white
        }
    }
    func setupDefaultNavigationBarDisAppearance() {
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.backgroundColor = .white
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.black]
        navigationController?.navigationBar.tintColor = .black
    }
    
    @objc func dismissKeyboard() {
        if messageTextField.isFirstResponder {
            messageTextField.resignFirstResponder()
        }
    }


    @IBAction func sendButtonTapped(_ sender: UIButton) {
        guard let text = messageTextField.text, !text.isEmpty else { return }
        
        let userMessage = ChatMessage(message: text, isFromAgent: false, timestamp: Date())
        chatMessages.append(userMessage)
        messageTextField.text = ""
        chatTableView.reloadData()
        scrollToBottom()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            let lowercasedText = text.lowercased()
            var reply = "I'm sorry, I didn't understand that. Can you rephrase?"
            
            let containsTrack = lowercasedText.contains("track") || lowercasedText.contains("book")
            let containsCancel = lowercasedText.contains("cancel") || lowercasedText.contains("remove")
            let containsHello = lowercasedText.contains("hello") || lowercasedText.contains("hi")
            
            if containsHello {
                reply = "Hello! How can I assist you today?"
            } else if containsTrack && self.extractBookingID(from: text) == nil {
                reply = "Sure, please provide your booking ID."
            } else if containsCancel && self.extractBookingID(from: text) == nil {
                reply = "To cancel a booking, please share your booking ID."
            } else if let bookingID = self.extractBookingID(from: text) {
                if containsCancel {
                    reply = "Your booking with ID #\(bookingID) has been successfully cancelled."
                } else {
                    reply = "Your booking with ID #\(bookingID) has been successfully booked."
                }
            }
            
            let agentReply = ChatMessage(message: reply, isFromAgent: true, timestamp: Date())
            self.chatMessages.append(agentReply)
            self.chatTableView.reloadData()
            self.scrollToBottom()
        }
    }
    func extractBookingID(from text: String) -> String? {
        let pattern = "\\d+"
        if let range = text.range(of: pattern, options: .regularExpression) {
            return String(text[range])
        }
        return nil
    }


    func scrollToBottom() {
        guard chatMessages.count > 0 else { return }
        let indexPath = IndexPath(row: chatMessages.count - 1, section: 0)
        chatTableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
    }

    // MARK: - TableView

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatMessages.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = chatMessages[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomerServiceChatTVC", for: indexPath) as! CustomerServiceChatTVC
        cell.configure(with: message)
        cell.selectionStyle = .none
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let message = chatMessages[indexPath.row].message
        let font = UIFont.systemFont(ofSize: 16)
        let bubbleWidth = tableView.frame.width * 0.6

        let textRect = NSString(string: message).boundingRect(
            with: CGSize(width: bubbleWidth, height: .greatestFiniteMagnitude),
            options: [.usesLineFragmentOrigin, .usesFontLeading],
            attributes: [.font: font],
            context: nil
        )

        let verticalPadding: CGFloat = 20
        let minHeight: CGFloat = 60
        let calculatedHeight = ceil(textRect.height) + verticalPadding

        return max(minHeight, calculatedHeight)
    }




    // MARK: - Keyboard Handling

    func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    
    @objc func handleKeyboard(notification: Notification) {
        guard let userInfo = notification.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = userInfo[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double,
              let curveValue = userInfo[UIResponder.keyboardAnimationCurveUserInfoKey] as? UInt else { return }

        let isKeyboardShowing = keyboardFrame.origin.y < UIScreen.main.bounds.height
        let bottomPadding = view.safeAreaInsets.bottom

        inputContainerBottomConstraint.constant = isKeyboardShowing ? keyboardFrame.height - bottomPadding : 0

        UIView.animate(withDuration: duration,
                       delay: 0,
                       options: UIView.AnimationOptions(rawValue: curveValue << 16),
                       animations: {
            self.view.layoutIfNeeded()
            self.scrollToBottom()
        }, completion: nil)
    }

}
