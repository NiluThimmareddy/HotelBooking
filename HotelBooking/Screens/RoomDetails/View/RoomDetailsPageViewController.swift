//
//  RoomDetailsPageViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 16/06/25.
//

/*
import UIKit

class RoomDetailsPageViewController: UIViewController {

    @IBOutlet weak var roomImagesTableview: UITableView!
    @IBOutlet weak var reserveButtonView: UIView!
    @IBOutlet weak var selectButtonView: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var stackViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var roomInfoLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        deleteButtonView.isHidden = true
        reserveButtonView.isHidden = true
        stackViewBottomConstraints.constant = 20
        selectButtonView.isHidden = false
    }
    
    
    @IBAction func selectButtonAction(_ sender: UIButton) {
        reserveButtonView.isHidden = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            stackViewBottomConstraints.constant = 200
        } else {
            stackViewBottomConstraints.constant = 150
        }
        selectButtonView.isHidden = true
        deleteButtonView.isHidden = false
    }
    
    
    @IBAction func reserveButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BookingOverviewVC") as! BookingOverviewVC
        controller.navigationItem.title = "Booking Overview"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

extension  RoomDetailsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomDetailsRoomImagesTableViewCell", for: indexPath) as! RoomDetailsRoomImagesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 350
        } else {
            return 250
        }
    }
}

extension RoomDetailsPageViewController {
    func UISetUp(){
        roomImagesTableview.register(UINib(nibName: "RoomDetailsRoomImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomDetailsRoomImagesTableViewCell")
        scrollView.delegate = self
        
        selectButtonView.isHidden = false
        deleteButtonView.isHidden = true
        reserveButtonView.isHidden = true
        stackViewBottomConstraints.constant = 20
        
        topView.backgroundColor = .clear
    }
}

extension RoomDetailsPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableViewFrameInView = roomImagesTableview.convert(roomImagesTableview.bounds, to: self.view)
        let isTableViewVisible = tableViewFrameInView.maxY > topView.frame.maxY
        
        if isTableViewVisible {
            topView.backgroundColor = .clear
            backButton.backgroundColor = UIColor.white.withAlphaComponent(0.39)
            shareButton.backgroundColor = UIColor.white.withAlphaComponent(0.39)
        } else {
            topView.backgroundColor = UIColor(hex: "003B95")
            backButton.backgroundColor = .clear
            shareButton.backgroundColor = .clear
        }
    }
}
*/

import UIKit

class RoomDetailsPageViewController: UIViewController {

    @IBOutlet weak var roomImagesTableview: UITableView!
    @IBOutlet weak var reserveButtonView: UIView!
    @IBOutlet weak var selectButtonView: UIView!
    @IBOutlet weak var deleteButtonView: UIView!
    @IBOutlet weak var stackViewBottomConstraints: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var roomInfoLabel: UILabel!
    @IBOutlet weak var datesLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var offerView: UIView!
    @IBOutlet weak var amenitiesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        showNavigationBar()
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareButtonAction(_ sender: Any) {
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        deleteButtonView.isHidden = true
        reserveButtonView.isHidden = true
        stackViewBottomConstraints.constant = 20
        selectButtonView.isHidden = false
    }
    
    
    @IBAction func selectButtonAction(_ sender: UIButton) {
        reserveButtonView.isHidden = false
        if UIDevice.current.userInterfaceIdiom == .pad {
            stackViewBottomConstraints.constant = 210
        } else {
            stackViewBottomConstraints.constant = 150
        }
        selectButtonView.isHidden = true
        deleteButtonView.isHidden = false
    }
    
    
    @IBAction func reserveButtonAction(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "BookingOverviewVC") as! BookingOverviewVC
        controller.navigationItem.title = "Booking Overview"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }

}

extension  RoomDetailsPageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoomDetailsRoomImagesTableViewCell", for: indexPath) as! RoomDetailsRoomImagesTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.userInterfaceIdiom == .pad {
            return 350
        } else {
            return 250
        }
    }
}

extension RoomDetailsPageViewController {
    func UISetUp(){
        roomImagesTableview.register(UINib(nibName: "RoomDetailsRoomImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomDetailsRoomImagesTableViewCell")
        scrollView.delegate = self
        
        selectButtonView.isHidden = false
        deleteButtonView.isHidden = true
        reserveButtonView.isHidden = true
        stackViewBottomConstraints.constant = 20
        
        topView.backgroundColor = .clear
        
        offerView.applyCardStyle()
        amenitiesView.applyCardStyle()
        
        if UIDevice.current.userInterfaceIdiom == .pad {
            backButton.layer.cornerRadius = 17.5
            shareButton.layer.cornerRadius = 17.5
        } else {
            backButton.layer.cornerRadius = 12.5
            shareButton.layer.cornerRadius = 12.5
        }
    }
}

extension RoomDetailsPageViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let tableViewFrameInView = roomImagesTableview.convert(roomImagesTableview.bounds, to: self.view)
        let isTableViewVisible = tableViewFrameInView.maxY > topView.frame.maxY
        
        if isTableViewVisible {
            topView.backgroundColor = .clear
            backButton.backgroundColor = UIColor.white.withAlphaComponent(0.39)
            shareButton.backgroundColor = UIColor.white.withAlphaComponent(0.39)
        } else {
            topView.backgroundColor = UIColor(hex: "003B95")
            backButton.backgroundColor = .clear
            shareButton.backgroundColor = .clear
        }
    }
}
