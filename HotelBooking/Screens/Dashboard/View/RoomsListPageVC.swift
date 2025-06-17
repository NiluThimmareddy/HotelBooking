//
//  RoomsListPageVC.swift
//  HotelBooking
//
//  Created by toqsoft on 09/06/25.
//

import UIKit

class RoomsListPageVC: UIViewController {

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var roomsListTableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var reserveButton: UIButton!
    
    var rooms: [Room] = [
        Room(hasOffer: true, hasImage: true),
        Room(hasOffer: nil, hasImage: true),
        Room(hasOffer: true, hasImage: true),
        Room(hasOffer: nil, hasImage: nil)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsListTableView.register(UINib(nibName: "RoomsListTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomsListTableViewCell")
        roomsListTableView.register(UINib(nibName: "RoomsListLwrTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomsListLwrTableViewCell")
         roomsListTableView.register(UINib(nibName: "RoomsListUprTableviewCell", bundle: nil), forCellReuseIdentifier: "RoomsListUprTableviewCell")
    }
    
    @IBAction func selectButtonAction(_ sender: UIBarButtonItem) {
        
    }
    
    @IBAction func reserveButtonAction(_ sender: Any) {
    }
}

extension RoomsListPageVC : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let room = rooms[indexPath.row]
        
        if room.hasOffer == true && room.hasImage == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListTableViewCell", for: indexPath) as! RoomsListTableViewCell
            return cell
        } else if room.hasImage == true {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListLwrTableViewCell", for: indexPath) as! RoomsListLwrTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListUprTableviewCell", for: indexPath) as! RoomsListUprTableviewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let room = rooms[indexPath.row]

        if room.hasOffer == true && room.hasImage == true {
            return 537
        } else if room.hasImage == true {
            return 418
        } else {
            return 522.3
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "RoomDetailsPage", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "RoomDetailsPageViewController") as! RoomDetailsPageViewController
        controller.navigationItem.title = "Room Details"
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
}
