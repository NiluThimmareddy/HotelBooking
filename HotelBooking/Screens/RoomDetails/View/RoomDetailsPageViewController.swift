//
//  RoomDetailsPageViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 16/06/25.
//

import UIKit

class RoomDetailsPageViewController: UIViewController {

    @IBOutlet weak var roomImagesTableview: UITableView!
    
    @IBOutlet weak var reserveButtonView: UIView!
    
    @IBOutlet weak var selectButtonView: UIView!
    
    @IBOutlet weak var deleteButtonView: UIView!
    
    
    @IBOutlet weak var stackViewBottomConstraints: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        UISetUp()
    }
    
    
    func UISetUp(){
        roomImagesTableview.register(UINib(nibName: "RoomDetailsRoomImagesTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomDetailsRoomImagesTableViewCell")
        
        selectButtonView.isHidden = false
        deleteButtonView.isHidden = true
        reserveButtonView.isHidden = true
        stackViewBottomConstraints.constant = 20
    }
    
    @IBAction func deleteButtonAction(_ sender: UIButton) {
        deleteButtonView.isHidden = true
        reserveButtonView.isHidden = true
        stackViewBottomConstraints.constant = 20
        selectButtonView.isHidden = false
    }
    
    
    @IBAction func selectButtonAction(_ sender: UIButton) {
        reserveButtonView.isHidden = false
        stackViewBottomConstraints.constant = 180
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
        return 230
    }
}
