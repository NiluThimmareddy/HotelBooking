//
//  CheckInCalendarVC.swift
//  HotelBooking
//
//  Created by praveenkumar on 09/06/25.
//
import UIKit
import FSCalendar

class CheckInCalendarVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {

    @IBOutlet weak var selectDateAndSearchButton: UIButton!
    @IBOutlet weak var howManyNightsLbl: UILabel!
    @IBOutlet weak var selectedDateRange: UILabel!
    @IBOutlet weak var approximatePriceForOneNightLbl: UILabel!
    @IBOutlet weak var alphaView: UIView!
    @IBOutlet weak var calendarView: UIView!
    @IBOutlet weak var backView: UIView!

    var calendar: FSCalendar!

    // MARK: - Date Selection State
    fileprivate var firstDate: Date?
    fileprivate var lastDate: Date?
    fileprivate var datesRange: [Date] = []

    
    let defaultSelectedColor = UIColor(named: "defaultColor") ?? .systemBlue
    let defaultRangeColor = UIColor.lightGray
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM"
        return formatter
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCalendar()
        backView.BackViewShadowAppyManually(cornerRadius: 20)
        alphaView.alpha = 0.1
        updateSelectedDateRangeLabel()
        applyTextFont()
    }
  
    private func updateSelectedDateRangeLabel() {
        if let first = firstDate, let last = lastDate {
            let nightCount = Calendar.current.dateComponents([.day], from: first, to: last).day ?? 0
            selectedDateRange.text = "\(dateFormatter.string(from: first)) - \(dateFormatter.string(from: last))"
            howManyNightsLbl.text = "(\(nightCount) \(nightCount == 1 ? "night" : "nights"))"
        } else if let first = firstDate {
            selectedDateRange.text = dateFormatter.string(from: first)
            howManyNightsLbl.text = ""
        } else {
            selectedDateRange.text = "Select your dates"
            howManyNightsLbl.text = "" 
        }
    }
    @IBAction func exitButton(_ sender: Any) {
        dismiss(animated: true)
    }
    func applyTextFont(){
        approximatePriceForOneNightLbl.font = .poppinsMedium(10)
        selectedDateRange.font = .poppinsBold(12)
        howManyNightsLbl.font = .poppinsBold(12)
        let selectDate = NSAttributedString(
            string: "Select Date and Search",
            attributes: [.font: UIFont.poppinsBold(14), .foregroundColor: UIColor.white]
        )
        selectDateAndSearchButton.setAttributedTitle(selectDate, for: .normal)
    }
    private func setupCalendar() {
        calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        calendar.delegate = self
        calendar.dataSource = self

        calendar.scope = .month
        calendar.scrollDirection = .vertical
        calendar.firstWeekday = 2
        calendar.allowsMultipleSelection = true
        
        calendar.appearance.headerTitleColor = .systemBlue
        calendar.appearance.weekdayTextColor = .darkGray
        calendar.appearance.titleTodayColor = .black
        calendar.appearance.subtitleTodayColor = .darkGray

        calendar.appearance.todayColor = nil
        
        calendar.appearance.borderRadius = 0.2
        
        calendar.appearance.subtitleOffset = CGPoint(x: 0, y: 5)

        calendar.appearance.headerTitleFont = UIFont.poppinsBold(14)
        calendar.appearance.weekdayFont = UIFont.poppinsMedium(12)
        calendar.appearance.titleFont = UIFont.poppinsMedium(12)
        calendar.appearance.subtitleFont = UIFont.poppinsMedium(10)

        calendarView.addSubview(calendar)

        NSLayoutConstraint.activate([
            calendar.topAnchor.constraint(equalTo: calendarView.topAnchor),
            calendar.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor),
            calendar.leadingAnchor.constraint(equalTo: calendarView.leadingAnchor),
            calendar.trailingAnchor.constraint(equalTo: calendarView.trailingAnchor)
        ])
    }

    // MARK: - FSCalendarDataSource

    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        let weekday = Calendar.current.component(.weekday, from: date)
        let today = Calendar.current.startOfDay(for: Date())

        if date < today {
            return nil // No subtitle for past dates
        }

        switch weekday {
        case 1: return "$170" // Sunday
        case 7: return "$150" // Saturday
        default: return "$100" // Monday to Friday
        }
    }

    // MARK: - FSCalendarDelegate

    func calendar(_ calendar: FSCalendar, shouldSelect date: Date, at monthPosition: FSCalendarMonthPosition) -> Bool {
        // Prevent selecting past dates
        return date >= Calendar.current.startOfDay(for: Date())
    }

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        if firstDate == nil {
            firstDate = date
            datesRange = [firstDate!]
            print("Selected first date: \(firstDate!)")
        }
        
        else if firstDate != nil && lastDate == nil {
           
            if date < firstDate! {
              
                calendar.deselect(firstDate!)
                firstDate = date
                datesRange = [firstDate!]
                print("Selected new first date (earlier): \(firstDate!)")
            } else {
                
                lastDate = date
                let orderedDates = [firstDate!, lastDate!].sorted()
                
                datesRange = dates(from: orderedDates[0], to: orderedDates[1])

                for d in datesRange {
                    if !calendar.selectedDates.contains(where: { Calendar.current.isDate($0, inSameDayAs: d) }) {
                        calendar.select(d, scrollToDate: false)
                    }
                }
                print("Selected range from \(firstDate!) to \(lastDate!). Total dates: \(datesRange.count)")
            }
        }
        else if firstDate != nil && lastDate != nil {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            firstDate = date
            lastDate = nil
            datesRange = [firstDate!]
            calendar.select(firstDate!)
            print("Cleared previous selection, new first date: \(firstDate!)")
        }
        
        calendar.reloadData()
    }

    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if datesRange.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            for d in calendar.selectedDates {
                calendar.deselect(d)
            }
            
            firstDate = nil
            lastDate = nil
            datesRange = []
            print("Cleared entire range due to deselection.")
            calendar.reloadData()
        }
    }

    // MARK: - FSCalendarDelegateAppearance
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        let today = Calendar.current.startOfDay(for: Date())
        
        if date < today {
            return .lightGray
        }
        
        var isFirstOrLastDate = false
        if let first = firstDate, Calendar.current.isDate(date, inSameDayAs: first) {
            isFirstOrLastDate = true
        }
        if let last = lastDate, Calendar.current.isDate(date, inSameDayAs: last) {
            isFirstOrLastDate = true
        }

        if isFirstOrLastDate {
            return .white
        }

        if datesRange.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            return .black
        }
        updateSelectedDateRangeLabel()
        return nil
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, subtitleDefaultColorFor date: Date) -> UIColor? {
        let today = Calendar.current.startOfDay(for: Date())
        if date < today {
            return .lightGray
        }

        var isFirstOrLastDate = false
        if let first = firstDate, Calendar.current.isDate(date, inSameDayAs: first) {
            isFirstOrLastDate = true
        }
        if let last = lastDate, Calendar.current.isDate(date, inSameDayAs: last) {
            isFirstOrLastDate = true
        }

        if isFirstOrLastDate {
            return .white
        }

        if datesRange.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            return .black
        }
        updateSelectedDateRangeLabel()
        return nil
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        return nil
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        var isFirstOrLastDate = false
        if let first = firstDate, Calendar.current.isDate(date, inSameDayAs: first) {
            isFirstOrLastDate = true
        }
        if let last = lastDate, Calendar.current.isDate(date, inSameDayAs: last) {
            isFirstOrLastDate = true
        }

        if isFirstOrLastDate {
            return defaultSelectedColor
        }
        
        if datesRange.contains(where: { Calendar.current.isDate($0, inSameDayAs: date) }) {
            return defaultRangeColor
        }
        
        return nil
    }

    // MARK: - FSCalendarDelegateAppearance for Cell Sizing
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, cellHeightFor date: Date) -> CGFloat {
        return 70.0
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, cellWidthFor date: Date) -> CGFloat {
        let defaultWidth = calendar.frame.width / 7.0
        return defaultWidth + 2.0
    }

    @IBAction func selectDateAndSearchButton(_ sender: Any) {
    }
    // MARK: - Helper to get dates between two dates
    func dates(from startDate: Date, to endDate: Date) -> [Date] {
        var dates: [Date] = []
        var currentDate = startDate

        let calendar = Calendar.current
        
        while currentDate <= endDate {
            dates.append(currentDate)
            guard let newDate = calendar.date(byAdding: .day, value: 1, to: currentDate) else { break }
            currentDate = newDate
        }
        return dates
    }
}


