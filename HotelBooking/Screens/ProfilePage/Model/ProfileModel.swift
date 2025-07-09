//
//  ProfileModel.swift
//  HotelBooking
//
//  Created by praveenkumar on 26/06/25.
//

import Foundation

struct ProfileOption {
    let listData: String
    let imageName: String
}

struct ProfileSection {
    let sectionTitle: String
    let options: [ProfileOption]
}

struct SecurityData {
    let securityTitle: String
    let securityContent: String
}

struct ChatMessage {
    let message: String
    let isFromAgent: Bool
    let timestamp: Date
}


struct NextRoomData{
    let roomId: String
    let roomImage: String
    let bookingStatus: String
    let roomType: String
    let roomBeds: String
    let roomSize: String
    let checkIn: String
    let checkOut: String
    let roomPrice: String
    let bookingReason: String
}

struct Guest {
    var firstName: String
    var lastName: String
    var dob: String
    var gender: String
}


struct NotificationData{
    var dateLbl: String
    var viewYourBooking: String
    var bookingConfirmation: String
    var hotelImage: String
}

enum chooseOptions{
    case add
    case edit
    case delete
}
