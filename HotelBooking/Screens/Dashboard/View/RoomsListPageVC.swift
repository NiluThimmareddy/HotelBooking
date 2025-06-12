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
        Room(hasOffer: false, hasImage: true),
        Room(hasOffer: false, hasImage: false)
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        roomsListTableView.register(UINib(nibName: "RoomsListTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomsListTableViewCell")
        roomsListTableView.register(UINib(nibName: "RoomsListLwrTableViewCell", bundle: nil), forCellReuseIdentifier: "RoomsListLwrTableViewCell")
        // roomsListTableView.register(UINib(nibName: "ThirdCell", bundle: nil), forCellReuseIdentifier: "ThirdCell")
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

        if room.hasOffer {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListTableViewCell", for: indexPath) as! RoomsListTableViewCell
            return cell
        } else if room.hasImage {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListLwrTableViewCell", for: indexPath) as! RoomsListLwrTableViewCell
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "RoomsListTableViewCell", for: indexPath) as! RoomsListTableViewCell
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let room = rooms[indexPath.row]
        
        if room.hasOffer {
            return 537
        } else if room.hasImage {
            return 418
        } else {
            return 537
        }
    }
}
