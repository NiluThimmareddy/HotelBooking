//
//  ViewAllFacilitiesVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 15/07/25.
//

import UIKit
enum SelectPoliciesOrFacilities{
    case policies
    case facilites
}
class ViewAllFacilitiesVC: UIViewController {
      
    @IBOutlet weak var policyTopContent: UILabel!
    @IBOutlet weak var childPoliciesTVHeightCons: NSLayoutConstraint! //default 380
    @IBOutlet weak var policiesTVHeightCons: NSLayoutConstraint! //default 100
    @IBOutlet weak var policiesChildContentViewHeightConstraint: NSLayoutConstraint! // default 502.33
    @IBOutlet weak var policiesChildContentView: UIView!
    @IBOutlet weak var policiesContentViewScroll: UIScrollView!
    @IBOutlet weak var childPoliciesTV: UITableView!
    @IBOutlet weak var policiesTV: UITableView!
    @IBOutlet weak var policyScrollContentView: UIView!
    //
    @IBOutlet weak var transportationCircleView: UIView!
    @IBOutlet weak var transportationCurveView: UIView!
    @IBOutlet weak var transportationTitle: UILabel!
    @IBOutlet weak var transportationTV: UITableView!
    @IBOutlet weak var parkingCircleView: UIView!
    @IBOutlet weak var parkingCurveView: UIView!
    @IBOutlet weak var parkingTitle: UILabel!
    @IBOutlet weak var parkingTV: UITableView!
    @IBOutlet weak var elevenAndTwelveTableViewStackViewHeight: NSLayoutConstraint!
    //
    @IBOutlet weak var securityCircleView: UIView!
    @IBOutlet weak var securityCurveView: UIView!
    @IBOutlet weak var securityTitle: UILabel!
    @IBOutlet weak var securityTV: UITableView!
    @IBOutlet weak var cleanCircleView: UIView!
    @IBOutlet weak var cleanCurveView: UIView!
    @IBOutlet weak var cleanTitle: UILabel!
    @IBOutlet weak var cleanTV: UITableView!
    @IBOutlet weak var nineAndTenTableViewStackViewHeight: NSLayoutConstraint!
    //
    @IBOutlet weak var receptionCircleView: UIView!
    @IBOutlet weak var receptionCurveView: UIView!
    @IBOutlet weak var receptionTitle: UILabel!
    @IBOutlet weak var receptionTV: UITableView!
    @IBOutlet weak var foodCircleView: UIView!
    @IBOutlet weak var foodCurveView: UIView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var foodTV: UITableView!
    @IBOutlet weak var sevenAndEightTableViewStackViewHeight: NSLayoutConstraint!
    //
    @IBOutlet weak var comfortCircleView: UIView!
    @IBOutlet weak var comfortCurveView: UIView!
    @IBOutlet weak var comfortTitle: UILabel!
    @IBOutlet weak var comfortTV: UITableView!
    @IBOutlet weak var internetCircleView: UIView!
    @IBOutlet weak var internetCurveView: UIView!
    @IBOutlet weak var internetTitle: UILabel!
    @IBOutlet weak var internetTV: UITableView!
    @IBOutlet weak var fiveAndSixTableViewStackViewHeight: NSLayoutConstraint!
    //
    @IBOutlet weak var kitchenCircleView: UIView!
    @IBOutlet weak var kitchenCurveView: UIView!
    @IBOutlet weak var kitchenTitle: UILabel!
    @IBOutlet weak var kitchenTV: UITableView!
    @IBOutlet weak var mediaCircleView: UIView!
    @IBOutlet weak var mediaCurveView: UIView!
    @IBOutlet weak var mediaTitle: UILabel!
    @IBOutlet weak var mediaTV: UITableView!
    @IBOutlet weak var threeAndFourTableViewStackViewHeight: NSLayoutConstraint!
    
    //
    @IBOutlet weak var bathroomCircleView: UIView!
    @IBOutlet weak var bathroomCurveView: UIView!
    @IBOutlet weak var bathroomTitle: UILabel!
    @IBOutlet weak var bathroomTV: UITableView!
    @IBOutlet weak var bedroomCircleView: UIView!
    @IBOutlet weak var bedroomCurveView: UIView!
    @IBOutlet weak var bedroomTitle: UILabel!
    @IBOutlet weak var bedroomTV: UITableView!
    @IBOutlet weak var oneAndTwoTableViewStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var additinalChargesTitle: UILabel!
    @IBOutlet weak var facilitiesTitle: UILabel!
    @IBOutlet weak var scrollViewScroll: UIScrollView!
    @IBOutlet weak var scrollViewContentView: UIView!
    @IBOutlet weak var scrollViewContentViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var segmentedControllerForFacilities: UISegmentedControl!
    
    var selectedState: SelectPoliciesOrFacilities = .facilites
    let topNameLbl: UILabel = {
       let label = UILabel()
       label.textColor = .white
       label.text = "All Facilities"
       label.font = UIFont.poppinsBold(16)
       label.textAlignment = .center
       return label
   }()
    var hotelFacilities: [HotelAllFacility] = [
        HotelAllFacility(title: "Bedroom", items: ["King Bed", "Air Conditioner", "Wardrobe"]),
        HotelAllFacility(title: "Bathroom", items: ["Shower", "Towels", "Toiletries"]),
        HotelAllFacility(title: "Media", items: ["TV", "Netflix", "Bluetooth Speaker"]),
        HotelAllFacility(title: "Kitchen", items: ["Microwave", "Fridge", "Utensils"]),
        HotelAllFacility(title: "Internet", items: ["Wi-Fi", "LAN Port"]),
        HotelAllFacility(title: "Comfort", items: ["Heater", "Sofa", "Fan"]),
        HotelAllFacility(title: "Food", items: ["Room Service", "Mini Bar"]),
        HotelAllFacility(title: "Reception", items: ["24/7 Desk", "Tour Help"]),
        HotelAllFacility(title: "Cleaning", items: ["Daily Cleaning", "Laundry"]),
        HotelAllFacility(title: "Security", items: ["CCTV", "Key Card Access"]),
        HotelAllFacility(title: "Parking", items: ["Free Parking", "Valet"]),
        HotelAllFacility(title: "Transportation", items: ["Airport Pickup", "Taxi Service"])
    ]
    var tableViewFacilityMap: [UITableView: HotelAllFacility] = [:]
    let allPolicies: [PolicyType] = [
        .general(HotelPolicy(
            title: "Check-In / Check-Out",
            details: [
                "Check-In Time: 2:00 PM",
                "Check-Out Time: 12:00 PM",
                "Early check-in or late check-out is subject to availability and may incur additional charges."
            ],
            systemImageName: "clock"
        )),
        .general(HotelPolicy(
            title: "Booking & Cancellation",
            details: [
                "A valid government-issued photo ID is required at check-in.",
                "Free cancellation is available up to 24 hours before check-in.",
                "No-shows will be charged for the first night.",
                "Advance bookings must be guaranteed with a credit/debit card or prepayment."
            ],
            systemImageName: "calendar.badge.minus"
        )),
        .children(ChildPolicy(
            title: "Children Policy",
            details: [
                "Children below 5 years stay free when using existing bedding.",
                "Extra beds are available on request and are chargeable.",
                "Baby cots may be available, subject to availability."
            ],
            priceContent: "To see correct prices and occupancy information, please add the number of children in your group and their ages to the search.",
            amountForAge: "5+ years",
            totalAmount: "$50",
            calculationContent: "Supplements are not calculated automatically in the total costs and will have to be paid for separately during your stay. All cots and extra beds are subject to availability. There is no capacity for cots.",
            systemImageName: "person.2.fill"
        )),
        .general(HotelPolicy(
            title: "Pets Policy",
            details: ["🐾 Pets are not allowed on the premises."],
            systemImageName: "pawprint.fill"
        )),
        .general(HotelPolicy(
            title: "Payment Policy",
            details: [
                "We accept cash, credit/debit cards, UPI, and online payments.",
                "A security deposit may be required upon check-in (refundable at checkout)."
            ],
            systemImageName: "creditcard.fill"
        )),
        .general(HotelPolicy(
            title: "Smoking Policy",
            details: [
                "Smoking is strictly prohibited in all rooms and indoor areas.",
                "Designated smoking zones are available outside the building.",
                "A cleaning fee will be charged if smoking is detected in rooms."
            ],
            systemImageName: "nosign"
        )),
        .general(HotelPolicy(
            title: "Guest Behavior",
            details: [
                "Guests are expected to respect staff and other guests.",
                "Any damages to hotel property will be charged to the guest.",
                "Management reserves the right to refuse service to anyone behaving inappropriately."
            ],
            systemImageName: "person.crop.circle.badge.exclam"
        )),
        .general(HotelPolicy(
            title: "Safety & Security",
            details: [
                "CCTV surveillance is in operation in common areas.",
                "Do not leave valuables unattended. Use the in-room safe (if available).",
                "The hotel is not responsible for the loss or damage of personal items."
            ],
            systemImageName: "lock.shield"
        )),
        .general(HotelPolicy(
            title: "Internet & Wi-Fi",
            details: [
                "Free Wi-Fi is available in rooms and common areas.",
                "Please ask the front desk for login details."
            ],
            systemImageName: "wifi"
        )),
        .general(HotelPolicy(
            title: "Housekeeping",
            details: [
                "Daily housekeeping is provided between 9:00 AM – 5:00 PM.",
                "Towels and linens are changed every 2 days or on request."
            ],
            systemImageName: "sparkles"
        )),
        .general(HotelPolicy(
            title: "Visitors Policy",
            details: [
                "Visitors are allowed only in the lobby.",
                "Room visits by non-registered guests are not permitted after 10:00 PM."
            ],
            systemImageName: "person.crop.circle.badge.questionmark"
        )),
        .general(HotelPolicy(
            title: "Alcohol Policy",
            details: [
                "Alcohol consumption is permitted in rooms only.",
                "Guests must comply with all local alcohol laws and restrictions."
            ],
            systemImageName: "wineglass.fill"
        ))
    ]



    override func viewDidLoad() {
        super.viewDidLoad()
        applyXibCell()
        fontText()
        tableViewProcess()
        segmentedProcess()
        navigationItem.titleView = topNameLbl
        segmentedActionProcess()
        DispatchQueue.main.async {
            self.policiesTV.reloadData()
            self.policiesTV.layoutIfNeeded()
        }

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            self.adjustPoliciesSectionHeight()
        }
    }

    func adjustPoliciesSectionHeight() {
        self.policiesTV.reloadData()
        self.childPoliciesTV.reloadData()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.policiesTV.layoutIfNeeded()
            self.childPoliciesTV.layoutIfNeeded()

            let policiesHeight = self.policiesTV.contentSize.height
            let childPoliciesHeight = self.childPoliciesTV.contentSize.height

            self.policiesTVHeightCons.constant = policiesHeight
            self.childPoliciesTVHeightCons.constant = childPoliciesHeight

            let padding: CGFloat = 20
            let totalHeight = policiesHeight + childPoliciesHeight + padding
            self.policiesChildContentViewHeightConstraint.constant = totalHeight

            // Ensure layout
            self.policiesChildContentView.setNeedsLayout()
            self.policiesChildContentView.layoutIfNeeded()

            self.scrollViewScroll.setNeedsLayout()
            self.scrollViewScroll.layoutIfNeeded()

            self.view.setNeedsLayout()
            self.view.layoutIfNeeded()
        }
    }


    func applyXibCell(){
        bedroomTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        bathroomTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        mediaTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        kitchenTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        internetTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        comfortTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        foodTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        receptionTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        cleanTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        securityTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        parkingTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        transportationTV.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
        policiesTV.register(UINib(nibName: "ViewAllPoliciesTV", bundle: nil), forCellReuseIdentifier: "ViewAllPoliciesTV")
        childPoliciesTV.register(UINib(nibName: "ChildDataPoliciesTVC", bundle: nil), forCellReuseIdentifier: "ChildDataPoliciesTVC")
        policiesTV.showsVerticalScrollIndicator = false
        policiesTV.showsHorizontalScrollIndicator = false
        policiesTV.estimatedRowHeight = 100
        policiesTV.rowHeight = UITableView.automaticDimension
        
    }
    
    func segmentedActionProcess(){
        policyScrollContentView.isHidden = true
        scrollViewScroll.isHidden = false
        switch selectedState {
        case .facilites:
            segmentedControllerForFacilities.selectedSegmentIndex = 0
        case .policies:
            segmentedControllerForFacilities.selectedSegmentIndex = 1
        }
        segmentedControllerForFacilities.sendActions(for: .valueChanged)
    }
    
    func tableViewProcess(){
        let facilityList: [UITableView: String] = [
            bedroomTV: "Bedroom",
            bathroomTV: "Bathroom",
            mediaTV: "Media",
            kitchenTV: "Kitchen",
            internetTV: "Internet",
            comfortTV: "Comfort",
            foodTV: "Food",
            receptionTV: "Reception",
            cleanTV: "Cleaning",
            securityTV: "Security",
            parkingTV: "Parking",
            transportationTV: "Transportation"
        ]
        
        for tv in facilityList.keys {
            tv.register(UINib(nibName: "UserFeedBackAfterCheckOutTVC", bundle: nil), forCellReuseIdentifier: "UserFeedBackAfterCheckOutTVC")
            tv.delegate = self
            tv.dataSource = self
            tv.isScrollEnabled = false
            
            if let title = facilityList[tv],
               let facility = hotelFacilities.first(where: { $0.title == title }) {
                tableViewFacilityMap[tv] = facility
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        roundTopRightCornerOnly()
        updateOneAndTwoTableStackHeight()
        updateThreeAndFourTableStackHeight()
        updateFiveAndSixTableStackHeight()
        updateSevenAndEightTableStackHeight()
        updateNineAndTenTableStackHeight()
        updateElevenAndTwelveTableStackHeight()
        updateScrollViewContentHeight()
        adjustPoliciesSectionHeight()
    }
    
    private func roundTopRightCornerOnly() {
        bedroomCurveView.layer.cornerRadius = bedroomCurveView.frame.size.height / 2
        bedroomCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        bedroomCircleView.layer.cornerRadius = bedroomCircleView.frame.size.height / 2
        
        bathroomCurveView.layer.cornerRadius = bathroomCurveView.frame.size.height / 2
        bathroomCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        bathroomCircleView.layer.cornerRadius = bathroomCircleView.frame.size.height / 2
        
        mediaCurveView.layer.cornerRadius = mediaCurveView.frame.size.height / 2
        mediaCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        mediaCircleView.layer.cornerRadius = mediaCircleView.frame.size.height / 2
        
        kitchenCurveView.layer.cornerRadius = kitchenCurveView.frame.size.height / 2
        kitchenCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        kitchenCircleView.layer.cornerRadius = kitchenCircleView.frame.size.height / 2
        
        internetCurveView.layer.cornerRadius = internetCurveView.frame.size.height / 2
        internetCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        internetCircleView.layer.cornerRadius = internetCircleView.frame.size.height / 2
        
        comfortCurveView.layer.cornerRadius = comfortCurveView.frame.size.height / 2
        comfortCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        comfortCircleView.layer.cornerRadius = comfortCircleView.frame.size.height / 2
        
        foodCurveView.layer.cornerRadius = foodCurveView.frame.size.height / 2
        foodCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        foodCircleView.layer.cornerRadius = foodCircleView.frame.size.height / 2
        
        receptionCurveView.layer.cornerRadius = receptionCurveView.frame.size.height / 2
        receptionCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        receptionCircleView.layer.cornerRadius = receptionCircleView.frame.size.height / 2
        
        cleanCurveView.layer.cornerRadius = cleanCurveView.frame.size.height / 2
        cleanCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        cleanCircleView.layer.cornerRadius = cleanCircleView.frame.size.height / 2
        
        securityCurveView.layer.cornerRadius = securityCurveView.frame.size.height / 2
        securityCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        securityCircleView.layer.cornerRadius = securityCircleView.frame.size.height / 2
        
        parkingCurveView.layer.cornerRadius = parkingCurveView.frame.size.height / 2
        parkingCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        parkingCircleView.layer.cornerRadius = parkingCircleView.frame.size.height / 2
        
        transportationCurveView.layer.cornerRadius = transportationCurveView.frame.size.height / 2
        transportationCurveView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        transportationCircleView.layer.cornerRadius = transportationCircleView.frame.size.height / 2
    }
    
    func updateOneAndTwoTableStackHeight() {
        let bedroomCount = tableViewFacilityMap[bedroomTV]?.items.count ?? 0
        let bathroomCount = tableViewFacilityMap[bathroomTV]?.items.count ?? 0
        
        let maxRowCount = max(bedroomCount, bathroomCount)
        let rowHeight: CGFloat = 40.0
        oneAndTwoTableViewStackViewHeight.constant = CGFloat(maxRowCount) * rowHeight
    }

    func updateThreeAndFourTableStackHeight() {
        let mediaCount = tableViewFacilityMap[mediaTV]?.items.count ?? 0
        let kitchenCount = tableViewFacilityMap[kitchenTV]?.items.count ?? 0
        
        let maxRowCount = max(mediaCount, kitchenCount)
        let rowHeight: CGFloat = 40.0
        threeAndFourTableViewStackViewHeight.constant = CGFloat(maxRowCount) * rowHeight
    }

    func updateFiveAndSixTableStackHeight() {
        let internetCount = tableViewFacilityMap[internetTV]?.items.count ?? 0
        let comfortCount = tableViewFacilityMap[comfortTV]?.items.count ?? 0
        
        let maxRowCount = max(internetCount, comfortCount)
        let rowHeight: CGFloat = 40.0
        fiveAndSixTableViewStackViewHeight.constant = CGFloat(maxRowCount) * rowHeight
    }

    func updateSevenAndEightTableStackHeight() {
        let foodCount = tableViewFacilityMap[foodTV]?.items.count ?? 0
        let receptionCount = tableViewFacilityMap[receptionTV]?.items.count ?? 0
        
        let maxRowCount = max(foodCount, receptionCount)
        let rowHeight: CGFloat = 40.0
        sevenAndEightTableViewStackViewHeight.constant = CGFloat(maxRowCount) * rowHeight
    }
    
    func updateNineAndTenTableStackHeight() {
        let cleaningCount = tableViewFacilityMap[cleanTV]?.items.count ?? 0
        let securityCount = tableViewFacilityMap[securityTV]?.items.count ?? 0
        
        let maxRowCount = max(cleaningCount, securityCount)
        let rowHeight: CGFloat = 40.0
        nineAndTenTableViewStackViewHeight.constant = CGFloat(maxRowCount) * rowHeight
    }

    func updateElevenAndTwelveTableStackHeight() {
        let parkingCount = tableViewFacilityMap[parkingTV]?.items.count ?? 0
        let transportCount = tableViewFacilityMap[transportationTV]?.items.count ?? 0
        
        let maxRowCount = max(parkingCount, transportCount)
        let rowHeight: CGFloat = 40.0
        elevenAndTwelveTableViewStackViewHeight.constant = CGFloat(maxRowCount) * rowHeight
    }

    func updateScrollViewContentHeight() {
        let rowHeight: CGFloat = 40.0

        let bedroomCount = tableViewFacilityMap[bedroomTV]?.items.count ?? 0
        let bathroomCount = tableViewFacilityMap[bathroomTV]?.items.count ?? 0
        let mediaCount = tableViewFacilityMap[mediaTV]?.items.count ?? 0
        let kitchenCount = tableViewFacilityMap[kitchenTV]?.items.count ?? 0
        let internetCount = tableViewFacilityMap[internetTV]?.items.count ?? 0
        let comfortCount = tableViewFacilityMap[comfortTV]?.items.count ?? 0
        let foodCount = tableViewFacilityMap[foodTV]?.items.count ?? 0
        let receptionCount = tableViewFacilityMap[receptionTV]?.items.count ?? 0
        let cleanCount = tableViewFacilityMap[cleanTV]?.items.count ?? 0
        let securityCount = tableViewFacilityMap[securityTV]?.items.count ?? 0
        let parkingCount = tableViewFacilityMap[parkingTV]?.items.count ?? 0
        let transportCount = tableViewFacilityMap[transportationTV]?.items.count ?? 0

        let height1 = CGFloat(max(bedroomCount, bathroomCount)) * rowHeight
        let height2 = CGFloat(max(mediaCount, kitchenCount)) * rowHeight
        let height3 = CGFloat(max(internetCount, comfortCount)) * rowHeight
        let height4 = CGFloat(max(foodCount, receptionCount)) * rowHeight
        let height5 = CGFloat(max(cleanCount, securityCount)) * rowHeight
        let height6 = CGFloat(max(parkingCount, transportCount)) * rowHeight

        let totalDynamicHeight = height1 + height2 + height3 + height4 + height5 + height6
        let baseHeight: CGFloat = 530

        scrollViewContentViewHeightConstraint.constant = baseHeight + totalDynamicHeight
    }

    func segmentedProcess(){
        let font = UIFont.poppinsBold(14)
        let selectedAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: font
        ]
        
        let normalAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: font
        ]
        
        segmentedControllerForFacilities.setTitleTextAttributes(normalAttributes, for: .normal)
        segmentedControllerForFacilities.setTitleTextAttributes(selectedAttributes, for: .selected)
        
        segmentedControllerForFacilities.backgroundColor = UIColor.systemGray5
    }

    func fontText(){
        facilitiesTitle.font = UIFont.poppinsBold(14)
        additinalChargesTitle.font = UIFont.poppinsBold(14)
        bedroomTitle.font = UIFont.poppinsBold(14)
        bathroomTitle.font = UIFont.poppinsBold(14)
        mediaTitle.font = UIFont.poppinsBold(14)
        kitchenTitle.font = UIFont.poppinsBold(14)
        internetTitle.font = UIFont.poppinsBold(14)
        comfortTitle.font = UIFont.poppinsBold(14)
        foodTitle.font = UIFont.poppinsBold(14)
        receptionTitle.font = UIFont.poppinsBold(14)
        cleanTitle.font = UIFont.poppinsBold(14)
        securityTitle.font = UIFont.poppinsBold(14)
        parkingTitle.font = UIFont.poppinsBold(14)
        transportationTitle.font = UIFont.poppinsBold(14)
        policyTopContent.font = UIFont.poppinsMedium(12)
    }
    
    @IBAction func segmentedControllerForFacilities(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            selectedState = .facilites
            policyScrollContentView.isHidden = true
            scrollViewScroll.isHidden = false
            topNameLbl.text = "All Facilities"
        } else {
            selectedState = .policies
            policyScrollContentView.isHidden = false
            scrollViewScroll.isHidden = true
            topNameLbl.text = "All Policies"
        }
    }
    
    func items(for title: String) -> [String] {
        return hotelFacilities.first(where: { $0.title == title })?.items ?? []
    }

}

extension ViewAllFacilitiesVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == policiesTV{
            return 1
        }else if tableView == childPoliciesTV{
            return 1
        }else{
            return 1
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == policiesTV {
            return allPolicies.filter {
                if case .general = $0 { return true }
                return false
            }.count
        } else if tableView == childPoliciesTV {
            return allPolicies.filter {
                if case .children = $0 { return true }
                return false
            }.count
        } else {
            return tableViewFacilityMap[tableView]?.items.count ?? 0
        }
    }


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == policiesTV {
            let generalPolicies = allPolicies.compactMap { policy -> HotelPolicy? in
                if case .general(let data) = policy { return data }
                return nil
            }
           
            let data = generalPolicies[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ViewAllPoliciesTV", for: indexPath) as! ViewAllPoliciesTV
            cell.otherPolicisImages.image = UIImage(systemName: data.systemImageName)
            cell.otherPoliciesTitle.text = data.title
            cell.otherPoliciesContent.text = data.details.joined(separator: "\n• ")
            return cell
        } else if tableView == childPoliciesTV {
            let childPolicies = allPolicies.compactMap { policy -> ChildPolicy? in
                if case .children(let data) = policy { return data }
                return nil
            }
            let data = childPolicies[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "ChildDataPoliciesTVC", for: indexPath) as! ChildDataPoliciesTVC
            cell.childPoliciesImage.image = UIImage(systemName: data.systemImageName)
            cell.childPoliciesTitle.text = data.title
            cell.childPoliciesContent.text = data.details.joined(separator: "\n• ")
            cell.childPolicyDetails = data
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "UserFeedBackAfterCheckOutTVC", for: indexPath) as! UserFeedBackAfterCheckOutTVC
            
            let items = tableViewFacilityMap[tableView]?.items ?? []
            cell.titleData.text = items[indexPath.row]
            cell.backView.backgroundColor = .clear
            return cell
        }
        
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == policiesTV {
            return UITableView.automaticDimension
        }else if tableView == childPoliciesTV{
            return 380
        } else {
            return 40
        }
    }

}
