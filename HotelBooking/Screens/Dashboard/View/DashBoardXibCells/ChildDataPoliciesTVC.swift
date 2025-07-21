//
//  ChildDataPoliciesTVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 16/07/25.
//

import UIKit

class ChildDataPoliciesTVC: UITableViewCell {
    
    @IBOutlet weak var childFinalContentLbl: UILabel!
    @IBOutlet weak var childPoliciesTV: UITableView!
    @IBOutlet weak var cotAndExtraBed: UILabel!
    @IBOutlet weak var toSeeCorrectPrice: UILabel!
    @IBOutlet weak var childPoliciesContent: UILabel!
    @IBOutlet weak var childPoliciesTitle: UILabel!
    @IBOutlet weak var childPoliciesImage: UIImageView!
    @IBOutlet weak var childPoliciesView: UIView!
    
    
    var childPolicyDetails: ChildPolicy? {
        didSet {
            childPoliciesTV.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        font()
        childPoliciesTV.delegate = self
        childPoliciesTV.dataSource = self
        childPoliciesTV.register(UINib(nibName: "ChildrenPoliciesTableViewCell", bundle: nil), forCellReuseIdentifier: "ChildrenPoliciesTableViewCell")
    
    }
    
    func font(){
        childFinalContentLbl.font = UIFont.poppinsMedium(12)
        cotAndExtraBed.font = UIFont.poppinsBold(14)
        toSeeCorrectPrice.font = UIFont.poppinsBold(12)
        childPoliciesContent.font = UIFont.poppinsMedium(12)
        childPoliciesTitle.font = UIFont.poppinsBold(16)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
}


extension ChildDataPoliciesTVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChildrenPoliciesTableViewCell")as! ChildrenPoliciesTableViewCell
        let policyText = childPolicyDetails
        cell.fromAge.text = policyText?.amountForAge
        cell.amountLbl.text = policyText?.totalAmount
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
