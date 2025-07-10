//
//  HomePageViewController.swift
//  HotelBooking
//
//  Created by ToqSoft on 19/05/25.
//

/*
import UIKit

class HomePageViewController: UIViewController, CalenderVCDelegate {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var hotelListCollectionView: UICollectionView!
    @IBOutlet weak var hotelRoomCollectionView: UICollectionView!
    @IBOutlet weak var propertyTypeCollectionView: UICollectionView!
    @IBOutlet weak var selectdateButton: UIButton!
    @IBOutlet weak var dealsView: UIView!
    @IBOutlet weak var bestPlaceImgView: UIImageView!
    @IBOutlet weak var dealsTitleLabel: UILabel!
    @IBOutlet weak var selectionDateLabel: UILabel!
    @IBOutlet weak var seeDealsButton: UIButton!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    @IBOutlet weak var roomAndAdultsButton: UIButton!
    
    let viewModel = HotelJsonViewModel()
    
    var offerScrollTimer: Timer?
    var currentOfferIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
        setupDefaultNavigationBarAppearance()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bestPlaceImgView.applyStrongLeftGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDefaultNavigationBarAppearance()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        offerScrollTimer?.invalidate()
        offerScrollTimer = nil
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

    @IBAction func selectdateButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "CalenderVC") as? CalenderVC else { return }
        controller.delegate = self
        
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * 0.65
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                sheet.largestUndimmedDetentIdentifier = .medium
                controller.preferredContentSize = CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * 0.5
                )
            }
        }
        
        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }
    
    func didSelectDateRange(_ dateRangeText: String) {
        selectdateButton.setTitle(dateRangeText, for: .normal)
    }
    
    @IBAction func roomAndAdultsButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SelectRoomsAndGuestsVC") as? SelectRoomsAndGuestsVC else { return }

        if let sheet = controller.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom(identifier: .medium, resolver: { context in
                        return context.maximumDetentValue * 0.65
                    })
                ]
                sheet.selectedDetentIdentifier = .medium
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20

                if UIDevice.current.userInterfaceIdiom == .pad {
                    sheet.largestUndimmedDetentIdentifier = nil
                    controller.preferredContentSize = CGSize(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height * 0.5
                    )
                }
            }
        }

        controller.modalPresentationStyle = .pageSheet

        controller.onApply = { [weak self] rooms, adults, children in
            let title = "\(rooms) Room\(rooms > 1 ? "s" : "") , \(adults) Adult\(adults > 1 ? "s" : "")" + (children > 0 ? " , \(children) Child\(children > 1 ? "ren" : "")" : "")
            self?.roomAndAdultsButton.setTitle(title, for: .normal)
        }

        present(controller, animated: true)
    }


    @IBAction func searchButtonAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func seeDealsButtonAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hotelListCollectionView, propertyTypeCollectionView:
            return min(6, viewModel.allHotels.count)
        case hotelRoomCollectionView:
            return min(6, viewModel.allRooms.count)
        default:
            return min(7, viewModel.allHotelDiscounts.count)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case hotelListCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedHotelsLwrCVC", for: indexPath) as! RecommendedHotelsLwrCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        case hotelRoomCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedRoomsLwrCVC", for: indexPath) as! RecommendedRoomsLwrCVC
            let item = viewModel.allRooms[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        case propertyTypeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyTypeCVC", for: indexPath) as! PropertyTypeCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopOffersCVC", for: indexPath) as! TopOffersCVC
            let discount = viewModel.allHotelDiscounts[indexPath.row]
            cell.configure(viewModel: viewModel, index: indexPath.row, discount: discount)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
        case hotelListCollectionView:
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            controller.hotelDetailsData = viewModel.allHotels[indexPath.row]
            controller.modalPresentationStyle = .fullScreen
            navigationItem.backButtonTitle = ""
            self.navigationController?.pushViewController(controller, animated: true)
        case hotelRoomCollectionView:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "RoomsListPageVC") as! RoomsListPageVC
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        case propertyTypeCollectionView:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        default :
            break
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth = collectionView.frame.width * 0.44
        let itemHeight = collectionView.frame.height
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

extension HomePageViewController {
    func setUpUI() {
        searchView.applyCardStyle()
        
        hotelListCollectionView.register(UINib(nibName: "RecommendedHotelsLwrCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendedHotelsLwrCVC")
        hotelRoomCollectionView.register(UINib(nibName: "RecommendedRoomsLwrCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendedRoomsLwrCVC")
        propertyTypeCollectionView.register(UINib(nibName: "PropertyTypeCVC", bundle: nil), forCellWithReuseIdentifier: "PropertyTypeCVC")
        offersCollectionView.register(UINib(nibName: "TopOffersCVC", bundle: nil), forCellWithReuseIdentifier: "TopOffersCVC")
        
        if let layout = hotelListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        if let layouts = hotelRoomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
        }
        
        if let propertyLayouts = propertyTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            propertyLayouts.estimatedItemSize = .zero
        }
        
        if let offersLayouts = offersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            offersLayouts.scrollDirection = .horizontal
            offersLayouts.estimatedItemSize = .zero
        }
        
        viewModel.fetchHotels {
            DispatchQueue.main.async {
                self.hotelListCollectionView.reloadData()
                self.hotelRoomCollectionView.reloadData()
                self.propertyTypeCollectionView.reloadData()
                self.offersCollectionView.reloadData()
            }
        }
        
        startOfferAutoScroll()
        offersCollectionView.isPagingEnabled = true

    }
    
    func startOfferAutoScroll() {
        offerScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self = self,
                  let collectionView = self.offersCollectionView else { return }

            let currentOffset = collectionView.contentOffset.x
            let contentWidth = collectionView.contentSize.width
            let frameWidth = collectionView.frame.size.width
            let nextOffset = currentOffset + frameWidth

            if nextOffset >= contentWidth {
                collectionView.setContentOffset(.zero, animated: false)
            } else {
                let newOffset = CGPoint(x: nextOffset, y: 0)
                collectionView.setContentOffset(newOffset, animated: true)
            }
        }
    }

}

*/


import UIKit

class HomePageViewController: UIViewController, CalenderVCDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var hotelListCollectionView: UICollectionView!
    @IBOutlet weak var hotelRoomCollectionView: UICollectionView!
    @IBOutlet weak var propertyTypeCollectionView: UICollectionView!
    @IBOutlet weak var selectdateButton: UIButton!
    @IBOutlet weak var dealsView: UIView!
    @IBOutlet weak var bestPlaceImgView: UIImageView!
    @IBOutlet weak var dealsTitleLabel: UILabel!
    @IBOutlet weak var selectionDateLabel: UILabel!
    @IBOutlet weak var seeDealsButton: UIButton!
    @IBOutlet weak var offersCollectionView: UICollectionView!
    @IBOutlet weak var roomAndAdultsButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var searchNameButton: UIButton!
    @IBOutlet weak var stackView: UIStackView!
    
    var selectedDateRange: String?
    var selectedDestination: String?
    
    let viewModel = HotelJsonViewModel()
    var offerScrollTimer: Timer?
    var currentOfferIndex = 0
    var selectedSegmentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        bestPlaceImgView.applyStrongLeftGradient()
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        configureTransparentNavBar()
//    }
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        scrollViewDidScroll(scrollView)
//    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        offerScrollTimer?.invalidate()
        offerScrollTimer = nil
        setupDefaultNavigationBarDisAppearance()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupDefaultNavigationBarAppearance()
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

    @IBAction func searchNameButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SearchBarViewController") as! SearchBarViewController
        storyboard.delegate = self
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(storyboard, animated: true)
    }  
    
    @IBAction func segmentControlAction(_ sender: UISegmentedControl) {
        selectedSegmentIndex = sender.selectedSegmentIndex
        hotelListCollectionView.reloadData()
    }

    @IBAction func selectdateButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "CalenderVC") as? CalenderVC else { return }
        controller.delegate = self
        
        if let sheet = controller.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return context.maximumDetentValue * 0.65
                }
            ]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
            
            if UIDevice.current.userInterfaceIdiom == .pad {
                sheet.largestUndimmedDetentIdentifier = .medium
                controller.preferredContentSize = CGSize(
                    width: UIScreen.main.bounds.width,
                    height: UIScreen.main.bounds.height * 0.5
                )
            }
        }
        
        controller.modalPresentationStyle = .pageSheet
        present(controller, animated: true)
    }
    
    func didSelectDateRange(_ dateRangeText: String) {
        selectdateButton.setTitle(dateRangeText, for: .normal)
        selectedDateRange = dateRangeText
    }
    
    @IBAction func roomAndAdultsButtonAction(_ sender: Any) {
        guard let controller = storyboard?.instantiateViewController(withIdentifier: "SelectRoomsAndGuestsVC") as? SelectRoomsAndGuestsVC else { return }

        if let sheet = controller.sheetPresentationController {
            if #available(iOS 16.0, *) {
                sheet.detents = [
                    .custom(identifier: .medium, resolver: { context in
                        return context.maximumDetentValue * 0.65
                    })
                ]
                sheet.selectedDetentIdentifier = .medium
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 20

                if UIDevice.current.userInterfaceIdiom == .pad {
                    sheet.largestUndimmedDetentIdentifier = nil
                    controller.preferredContentSize = CGSize(
                        width: UIScreen.main.bounds.width,
                        height: UIScreen.main.bounds.height * 0.5
                    )
                }
            }
        }

        controller.modalPresentationStyle = .pageSheet

        controller.onApply = { [weak self] rooms, adults, children in
            let title = "\(rooms) Room\(rooms > 1 ? "s" : "") , \(adults) Adult\(adults > 1 ? "s" : "")" + (children > 0 ? " , \(children) Child\(children > 1 ? "ren" : "")" : "")
            self?.roomAndAdultsButton.setTitle(title, for: .normal)
        }

        present(controller, animated: true)
    }
    
    @IBAction func searchButtonAction(_ sender: Any) {
        guard let destination = selectedDestination,
              let dateRange = selectedDateRange else {
            print("Destination or Date range missing")
            return
        }

        var history: [SearchHistoryItem] = []
        if let data = UserDefaults.standard.data(forKey: "SearchHistory"),
           let decoded = try? JSONDecoder().decode([SearchHistoryItem].self, from: data) {
            history = decoded
        }

        if let index = history.firstIndex(where: { $0.destination == destination }) {
            history.remove(at: index)
        }

        let newItem = SearchHistoryItem(destination: destination, dateRange: dateRange)
        history.insert(newItem, at: 0)
        history = Array(history.prefix(5))

        if let encoded = try? JSONEncoder().encode(history) {
            UserDefaults.standard.set(encoded, forKey: "SearchHistory")
        }

        let controller = storyboard?.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(controller, animated: true)
    }

    
    @IBAction func seeDealsButtonAction(_ sender: Any) {
        let controller = storyboard?.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    @IBAction func recentlySeemoreButtonAction(_ sender: Any) {
        let storyboard = UIStoryboard(name: "History", bundle: nil).instantiateViewController(withIdentifier: "HistoryViewController") as! HistoryViewController
        self.navigationController?.pushViewController(storyboard, animated: true)
    }
    
    @IBAction func popularSeemoreButtonAction(_ sender: Any) {
        let controller = UIStoryboard(name: "Review", bundle: nil).instantiateViewController(withIdentifier: "PostReviewViewController") as! PostReviewViewController
        let backItem = UIBarButtonItem()
        backItem.title = ""
        self.navigationItem.backBarButtonItem = backItem
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}

extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case hotelListCollectionView:
            let totalHotels = viewModel.allHotels.count
            if selectedSegmentIndex == 0 {
                return min(6, totalHotels)
            } else if selectedSegmentIndex == 1 {
                return max(0, min(6, totalHotels - 6))
            }
            return 0
        case propertyTypeCollectionView:
            return min(6, viewModel.allHotels.count)
        case hotelRoomCollectionView:
            return min(6, viewModel.allRooms.count)
        default:
            return min(7, viewModel.allHotelDiscounts.count)
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case hotelListCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecommendedHotelsLwrCVC", for: indexPath) as! RecommendedHotelsLwrCVC
            let startIndex = selectedSegmentIndex == 0 ? 0 : 6
            cell.hotelimages.reverse()
            cell.startingRate.reverse()
            let itemIndex = startIndex + indexPath.row
            if itemIndex < viewModel.allHotels.count {
                let item = viewModel.allHotels[itemIndex]
                cell.configure(with: item, index: itemIndex)
            }
            return cell
            
        case hotelRoomCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecentlyViewedCVC", for: indexPath) as! RecentlyViewedCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        case propertyTypeCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "popularPlacesCVC", for: indexPath) as! popularPlacesCVC
            let item = viewModel.allHotels[indexPath.row]
            cell.configure(with: item, index: indexPath.item)
            return cell
            
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TopOffersCVC", for: indexPath) as! TopOffersCVC
            let discount = viewModel.allHotelDiscounts[indexPath.row]
            cell.configure(viewModel: viewModel, index: indexPath.row, discount: discount)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        switch collectionView {
        case hotelListCollectionView:
            let storyboard = UIStoryboard(name: "HomePage", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "DetailsViewController") as! DetailsViewController
            controller.hotelDetailsData = viewModel.allHotels[indexPath.row]
            controller.modalPresentationStyle = .fullScreen
            navigationItem.backButtonTitle = ""
            self.navigationController?.pushViewController(controller, animated: true)
        case hotelRoomCollectionView:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "RoomsListPageVC") as! RoomsListPageVC
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        case propertyTypeCollectionView:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "HotelListPageVC") as! HotelListPageVC
            controller.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(controller, animated: true)
        default :
            break
        }

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch collectionView {
        case hotelListCollectionView:
            let itemWidth = collectionView.frame.width * 0.5
            let baseHeight = collectionView.frame.height / 3
//            let itemHeight = indexPath.item % 2 == 0 ? baseHeight : baseHeight + 20
            return CGSize(width: itemWidth, height: baseHeight)
        case propertyTypeCollectionView:
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let itemsPerRow: CGFloat = isIpad ? 5 : (1 / 0.35)
            let spacing: CGFloat = 10
            let totalSpacing = spacing * (itemsPerRow - 1)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            let itemHeight = collectionView.frame.height
            return CGSize(width: itemWidth, height: itemHeight)
        case hotelRoomCollectionView :
            let itemWidth = collectionView.frame.width * 0.3
            let itemHeight = collectionView.frame.height
            return CGSize(width: itemWidth, height: itemHeight)
        default:
            let isIpad = UIDevice.current.userInterfaceIdiom == .pad
            let itemsPerRow: CGFloat = isIpad ? 1.97 : 1
            let spacing: CGFloat = 10
            let totalSpacing = spacing * (itemsPerRow - 1)
            let itemWidth = (collectionView.frame.width - totalSpacing) / itemsPerRow
            let itemHeight = collectionView.frame.height
            return CGSize(width: itemWidth, height: itemHeight)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == propertyTypeCollectionView {
            return 10
        } else if collectionView == hotelListCollectionView || collectionView == hotelRoomCollectionView || collectionView == offersCollectionView {
            return 0
        }
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    

}

extension HomePageViewController : SearchBarViewControllerDelegate {
    
    func didSelectSearchResult(_ result: String, withDateRange dateRange: String) {
        searchNameButton.setTitle(result, for: .normal)
        selectedDestination = result
        selectedDateRange = dateRange
    }
    
    func setUpUI() {
        searchView.applyCardStyle()
        scrollView.delegate = self
        
        hotelListCollectionView.register(UINib(nibName: "RecommendedHotelsLwrCVC", bundle: nil), forCellWithReuseIdentifier: "RecommendedHotelsLwrCVC")
        hotelRoomCollectionView.register(UINib(nibName: "RecentlyViewedCVC", bundle: nil), forCellWithReuseIdentifier: "RecentlyViewedCVC")
        propertyTypeCollectionView.register(UINib(nibName: "popularPlacesCVC", bundle: nil), forCellWithReuseIdentifier: "popularPlacesCVC")
        offersCollectionView.register(UINib(nibName: "TopOffersCVC", bundle: nil), forCellWithReuseIdentifier: "TopOffersCVC")
        
        if let layout = hotelListCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.estimatedItemSize = .zero
        }
        
        if let layouts = hotelRoomCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layouts.estimatedItemSize = .zero
        }
        
        if let propertyLayouts = propertyTypeCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            propertyLayouts.estimatedItemSize = .zero
        }
        
        if let offersLayouts = offersCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            offersLayouts.scrollDirection = .horizontal
            offersLayouts.estimatedItemSize = .zero
        }
                
        viewModel.fetchHotels {
            DispatchQueue.main.async {
                self.hotelListCollectionView.reloadData()
                self.hotelRoomCollectionView.reloadData()
                self.propertyTypeCollectionView.reloadData()
                self.offersCollectionView.reloadData()
            }
        }
        
        startOfferAutoScroll()
        offersCollectionView.isPagingEnabled = true
        
        let selectedTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white
        ]
        segmentControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
        
        stackView.clipsToBounds = true
        stackView.layer.cornerRadius = 20
        stackView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        //        configureTransparentNavBar()
    }
    
//    func configureTransparentNavBar() {
//        guard let navBar = navigationController?.navigationBar else { return }
//
//        navBar.setBackgroundImage(UIImage(), for: .default)
//        navBar.shadowImage = UIImage()
//        navBar.isTranslucent = true
//        navBar.backgroundColor = UIColor(red: 0/255, green: 59/255, blue: 149/255, alpha: 0)
//        navBar.tintColor = UIColor.white.withAlphaComponent(0)
//        navBar.titleTextAttributes = [
//            NSAttributedString.Key.foregroundColor: UIColor.white.withAlphaComponent(0)
//        ]
//    }

    func startOfferAutoScroll() {
        offerScrollTimer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { [weak self] _ in
            guard let self = self,
                  let collectionView = self.offersCollectionView else { return }

            let currentOffset = collectionView.contentOffset.x
            let contentWidth = collectionView.contentSize.width
            let frameWidth = collectionView.frame.size.width
            let nextOffset = currentOffset + frameWidth

            if nextOffset >= contentWidth {
                collectionView.setContentOffset(.zero, animated: false)
            } else {
                let newOffset = CGPoint(x: nextOffset, y: 0)
                collectionView.setContentOffset(newOffset, animated: true)
            }
        }
    }

}

//extension HomePageViewController: UIScrollViewDelegate {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let offsetY = scrollView.contentOffset.y
//        let fadeRange: CGFloat = 150
//        let alpha = min(max(offsetY / fadeRange, 0), 1)
//
//        let backgroundColor = UIColor(red: 0/255, green: 59/255, blue: 149/255, alpha: alpha)
//        let textColor = UIColor.white.withAlphaComponent(alpha)
//
//        UIView.animate(withDuration: 0.15) {
//            self.navigationController?.navigationBar.backgroundColor = backgroundColor
//            self.navigationController?.navigationBar.tintColor = textColor
//            self.navigationController?.navigationBar.titleTextAttributes = [
//                NSAttributedString.Key.foregroundColor: textColor
//            ]
//        }
//    }
//}
