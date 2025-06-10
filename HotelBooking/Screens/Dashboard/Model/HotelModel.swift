//
//  HotelModel.swift
//  HotelBooking
//
//  Created by toqsoft on 21/05/25.
//

import Foundation

struct HotelJsonRoot: Codable {
    let Hotels: [Hotel]?
    let Policies: [Policy]?
    let SeasonalPrices: [SeasonalPrice]?
    let RoomAvailability: [RoomAvailability]?
    let HotelRooms: [HotelRoom]?
    let HotelImages: [HotelImage]?
    enum CodingKeys: String, CodingKey {
        case Hotels
        case Policies = "HotelPolicies"
        case SeasonalPrices = "RoomSeasonalPrices"
        case RoomAvailability
        case HotelRooms = "HotelRooms"
        case HotelImages = "HotelImages"
    }
}

struct Hotel: Codable {
    let HotelId: String
    let HotelName: String
    let ShortDescription: String
    let Description: String
    let HotelType: String
    let StarRating: Double?
    let HotelChain: String
    let LogoUrl: String
    let CoverImageUrl: String
    let Country: String
    let StateOrProvince: String
    let City: String
    let AddressLine1: String
    let AddressLine2: String
    let PostalCode: String
    let Latitude: Double
    let Longitude: Double
    let Email: String
    let PrimaryPhone: String
    let WebsiteUrl: String
    let CheckInTime: String
    let CheckOutTime: String
    let CovidSafetyLevel: String
    let AcceptedCurrencies: String
    let LanguagesSpoken: String
    let IsActive: Bool
    let CreatedDate: String
}

struct HotelImage: Codable {
    let imageId: String
    let hotelId: String
    let imageUrl: String
    let description: String
    let isPrimary: Bool

    enum CodingKeys: String, CodingKey {
        case imageId = "ImageId"
        case hotelId = "HotelId"
        case imageUrl = "ImageUrl"
        case description = "Description"
        case isPrimary = "IsPrimary"
    }
}

struct Policy: Codable {
    let PolicyId: String
    let HotelId: String
    let PolicyType: String
    let Description: String
}

struct HotelLandmark: Codable {
    let landmarkId: String
    let hotelId: String
    let landmarkName: String
    let distanceInKm: Double
    let landmarkType: String

    enum CodingKeys: String, CodingKey {
        case landmarkId = "LandmarkId"
        case hotelId = "HotelId"
        case landmarkName = "LandmarkName"
        case distanceInKm = "DistanceInKm"
        case landmarkType = "LandmarkType"
    }
}

struct HotelDiscount: Codable {
    let discountId: String
    let hotelId: String
    let title: String
    let description: String
    let discountPercentage: Double
    let validFrom: String
    let validTo: String

    enum CodingKeys: String, CodingKey {
        case discountId = "DiscountId"
        case hotelId = "HotelId"
        case title = "Title"
        case description = "Description"
        case discountPercentage = "DiscountPercentage"
        case validFrom = "ValidFrom"
        case validTo = "ValidTo"
    }
}

struct HotelFacility: Codable {
    let facilityId: String
    let facilityName: String
    let category: String

    enum CodingKeys: String, CodingKey {
        case facilityId = "FacilityId"
        case facilityName = "FacilityName"
        case category = "Category"
    }
}

struct HotelFacilityAvailability: Codable {
    let hotelFacilityId: String
    let hotelId: String
    let facilityId: String
    let isAvailable: Bool

    enum CodingKeys: String, CodingKey {
        case hotelFacilityId = "HotelFacilityId"
        case hotelId = "HotelId"
        case facilityId = "FacilityId"
        case isAvailable = "IsAvailable"
    }
}

struct HotelRoom: Codable {
    let roomId: String
    let hotelId: String
    let roomType: String
    let roomName: String
    let bedType: String
    let maxAdults: Int
    let maxChildren: Int
    let roomSize: String
    let basePrice: Double
    let roomStatus: String
    let refundPolicy: String
    let breakfastIncluded: Bool
    let availableRooms: Int
    let roomImages: [String]

    enum CodingKeys: String, CodingKey {
        case roomId = "RoomId"
        case hotelId = "HotelId"
        case roomType = "RoomType"
        case roomName = "RoomName"
        case bedType = "BedType"
        case maxAdults = "MaxAdults"
        case maxChildren = "MaxChildren"
        case roomSize = "RoomSize"
        case basePrice = "BasePrice"
        case roomStatus = "RoomStatus"
        case refundPolicy = "RefundPolicy"
        case breakfastIncluded = "BreakfastIncluded"
        case availableRooms = "AvailableRooms"
        case roomImagesJson = "RoomImagesJson"
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        roomId = try container.decode(String.self, forKey: .roomId)
        hotelId = try container.decode(String.self, forKey: .hotelId)
        roomType = try container.decode(String.self, forKey: .roomType)
        roomName = try container.decode(String.self, forKey: .roomName)
        bedType = try container.decode(String.self, forKey: .bedType)
        maxAdults = try container.decode(Int.self, forKey: .maxAdults)
        maxChildren = try container.decode(Int.self, forKey: .maxChildren)
        roomSize = try container.decode(String.self, forKey: .roomSize)
        basePrice = try container.decode(Double.self, forKey: .basePrice)
        roomStatus = try container.decode(String.self, forKey: .roomStatus)
        refundPolicy = try container.decode(String.self, forKey: .refundPolicy)
        breakfastIncluded = try container.decode(Bool.self, forKey: .breakfastIncluded)
        availableRooms = try container.decode(Int.self, forKey: .availableRooms)

        let roomImagesJson = try container.decode(String.self, forKey: .roomImagesJson)
        if let data = roomImagesJson.data(using: .utf8) {
            roomImages = (try? JSONDecoder().decode([String].self, from: data)) ?? []
        } else {
            roomImages = []
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(roomId, forKey: .roomId)
        try container.encode(hotelId, forKey: .hotelId)
        try container.encode(roomType, forKey: .roomType)
        try container.encode(roomName, forKey: .roomName)
        try container.encode(bedType, forKey: .bedType)
        try container.encode(maxAdults, forKey: .maxAdults)
        try container.encode(maxChildren, forKey: .maxChildren)
        try container.encode(roomSize, forKey: .roomSize)
        try container.encode(basePrice, forKey: .basePrice)
        try container.encode(roomStatus, forKey: .roomStatus)
        try container.encode(refundPolicy, forKey: .refundPolicy)
        try container.encode(breakfastIncluded, forKey: .breakfastIncluded)
        try container.encode(availableRooms, forKey: .availableRooms)

        let roomImagesData = try JSONEncoder().encode(roomImages)
        if let jsonString = String(data: roomImagesData, encoding: .utf8) {
            try container.encode(jsonString, forKey: .roomImagesJson)
        }
    }
}

struct RoomFacility: Codable {
    let roomFacilityId: String
    let roomId: String
    let facilityId: String

    enum CodingKeys: String, CodingKey {
        case roomFacilityId = "RoomFacilityId"
        case roomId = "RoomId"
        case facilityId = "FacilityId"
    }
}

struct SeasonalPrice: Codable {
    let SeasonalPriceId: String
    let RoomId: String
    let StartDate: String
    let EndDate: String
    let Price: Double
}

struct RoomAvailability: Codable {
    let RoomId: String
    let Date: String
    let AvailableCount: Int
}

