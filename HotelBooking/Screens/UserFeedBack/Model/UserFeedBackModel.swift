//
//  UserFeedBackModel.swift
//  HotelBooking
//
//  Created by praveenkumar on 21/07/25.
//

import Foundation

struct HotelFeedBackInfo {
    var hotelImage: String
    var hotelName: String
    var bookedDate: String
    var hotelLocation: String
    var status: String
    var process: String
    var daysRemaining: String {
            if status == "Completed" {
                return "0"
            }

            // Extract checkout date from bookedDate
            let components = bookedDate.components(separatedBy: " - ")
            guard components.count == 2 else { return "Invalid date" }

            let endDateString = components[1] // e.g., "16 May 2025"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            guard let endDate = dateFormatter.date(from: endDateString) else {
                return "Invalid date"
            }

            // Add 30 days from checkout date
            let reviewDeadline = Calendar.current.date(byAdding: .day, value: 30, to: endDate)!

            let daysLeft = Calendar.current.dateComponents([.day], from: Date(), to: reviewDeadline).day ?? 0

            return daysLeft > 0 ? "\(daysLeft) days left to write your review" : "Review time expired"
        }
    }
