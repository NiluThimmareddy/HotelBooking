//
//  UserFeedBackListVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 18/06/25.
//

import UIKit

class UserFeedBackListVC: UIViewController {

    @IBOutlet weak var feedBackListTV: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let appearance = UIBarButtonItem.appearance()
        appearance.setTitleTextAttributes([.font: UIFont.boldSystemFont(ofSize: 17)], for: .normal)
        feedBackListTV.register(UINib(nibName: "UserFeedBackListTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackListTVC")
        feedBackListTV.showsVerticalScrollIndicator = false
        feedBackListTV.showsHorizontalScrollIndicator = false
    }
    

    
}

extension UserFeedBackListVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserFeedBackListTVC")as! UserFeedBackListTVC
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 210
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "UserFeedBack", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "UserFeedBackAfterCheckOutVC")as! UserFeedBackAfterCheckOutVC
        navigationItem.backButtonTitle = ""
        navigationController?.pushViewController(vc, animated: true)
    }
}
