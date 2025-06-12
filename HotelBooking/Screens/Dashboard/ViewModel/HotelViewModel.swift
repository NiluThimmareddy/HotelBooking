

import Foundation

enum DisplayMode {
    case hotel, seasonalPrice, policy, roomAvailability, hotelRooms, hotelImages, hotelNearbyLandmarks, hotelDiscounts, facility, hotelFacilityAvailability, roomFacility
}

class HotelJsonViewModel {

    var allHotels: [Hotel] = []
    var allSeasonalPrices: [SeasonalPrice] = []
    var allPolicies: [Policy] = []
    var allRoomAvailability: [RoomAvailability] = []
    var allRooms: [HotelRoom] = []
    var allhotelImages: [HotelImage] = []
    var allHotelNearbyLandmarks: [HotelLandmark] = []
    var allHotelDiscounts: [HotelDiscount] = []
    var allFacilities: [HotelFacility] = []
    var allHotelFacilityAvailabilities: [HotelFacilityAvailability] = []
    var allRoomFacilities: [RoomFacility] = []
    
    var loadedItems: [String] = []
    var currentPage = 0
    let pageSize = 10
    var displayMode: DisplayMode = .hotel

    var totalPages: Int {
        let count: Int
        switch displayMode {
        case .hotel: count = allHotels.count
        case .seasonalPrice: count = allSeasonalPrices.count
        case .policy: count = allPolicies.count
        case .roomAvailability: count = allRoomAvailability.count
        case .hotelRooms: count = allRooms.count
        case .hotelImages: count = allhotelImages.count
        case .hotelNearbyLandmarks: count = allHotelNearbyLandmarks.count
        case .hotelDiscounts: count = allHotelDiscounts.count
        case .facility: count = allFacilities.count
        case .hotelFacilityAvailability: count = allHotelFacilityAvailabilities.count
        case .roomFacility: count = allRoomFacilities.count
        }
        return Int(ceil(Double(count) / Double(pageSize)))
    }
    
    var bankImages = ["ic_hdfc","ic_canara","ic_punjab_bank","ic_doller","ic_hotel 1","ic_card","ic_Bank"]
    var percentage = ["Flat 20% off","Flat 20% off","Flat 15% off","3 months no cost EMI","Min. 20% off","5% unlimited cashback", "Flat 20% off"]
    var descriptions = ["on hotels with HDFC Bank Credit Card. T&C","on hotels with canara bank credit card T&C","on hotels with punjab national bank credit card. T&C","on all leading bank credit cards","on top international hotels","on your flipkart axis bank credit card T&C", "on hotels with Bank of Baroda Credit Card. T&C"]
    var offerCode = ["HDFCCC","CANARACC","PNBCC","","","","BOBCC"]

    var allItemsForCurrentMode: [String] {
        switch displayMode {
        case .hotel:
            return allHotels.map { "Hotel Name: \($0.HotelName)\nHotel Type: \($0.HotelType)" }

        case .seasonalPrice:
            return allSeasonalPrices.map { "Room ID: \($0.RoomId)\nPrice: \($0.Price)\nFrom: \($0.StartDate)\nTo: \($0.EndDate)" }

        case .policy:
            return allPolicies.map { "Hotel ID: \($0.HotelId)\nPolicy Type: \($0.PolicyType)\nDescription: \($0.Description)" }

        case .roomAvailability:
            return allRoomAvailability.map { "Room ID: \($0.RoomId)\nDate: \($0.Date)\nAvailable Count: \($0.AvailableCount)" }

        case .hotelRooms:
            return allRooms.map { "Room ID: \($0.roomId)\nRoom Type: \($0.roomType)\nHotel ID: \($0.hotelId)" }

        case .hotelImages:
            return allhotelImages.map { "Hotel ID: \($0.hotelId)\nImage URL: \($0.imageUrl)\nImage ID: \($0.imageId)" }

        case .hotelNearbyLandmarks:
            return allHotelNearbyLandmarks.map { "Hotel ID: \($0.hotelId)\nLandmark: \($0.landmarkName)\nDistance: \($0.distanceInKm)" }

        case .hotelDiscounts:
            return allHotelDiscounts.map { "Hotel ID: \($0.hotelId)\nDiscount: \($0.discountPercentage)%\nFrom: \($0.validFrom)\nTo: \($0.validTo)" }

        case .facility:
            return allFacilities.map { "Facility ID: \($0.facilityId)\nFacility Name: \($0.facilityName)" }

        case .hotelFacilityAvailability:
            return allHotelFacilityAvailabilities.map { "Hotel ID: \($0.hotelId)\nFacility ID: \($0.facilityId)\nAvailable: \($0.isAvailable ? "Yes" : "No")" }

        case .roomFacility:
            return allRoomFacilities.map { "Room ID: \($0.roomId)\nFacility ID: \($0.facilityId)" }
        }
    }

    func fetchHotels(completion: @escaping () -> Void) {
        loadJson { success in
            completion()
        }
    }

    func loadJson(completion: @escaping (Bool) -> Void) {
        guard let path = Bundle.main.path(forResource: "HotelJsonData", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path)) else {
            print("Could not find or read HotelJsonData.json")
            completion(false)
            return
        }

        do {
            let decoded = try JSONDecoder().decode(HotelJsonRoot.self, from: data)
            self.allHotels = decoded.Hotels ?? []
            self.allPolicies = decoded.Policies ?? []
            self.allSeasonalPrices = decoded.SeasonalPrices ?? []
            self.allRoomAvailability = decoded.RoomAvailability ?? []
            self.allhotelImages = decoded.HotelImages ?? []
            self.allRooms = decoded.HotelRooms ?? []
            self.allHotelNearbyLandmarks = decoded.HotelNearbyLandmark ?? []
            self.allHotelDiscounts = decoded.HotelDiscounts ?? []
            self.allFacilities = decoded.Facilities ?? []
            self.allHotelFacilityAvailabilities = decoded.HotelFacilities ?? []
            self.allRoomFacilities = decoded.RoomFacility ?? []
            
            currentPage = 0
            loadedItems = getPageItems(forPage: currentPage)
            completion(true)
        } catch {
            print("JSON decoding failed: \(error)")
            completion(false)
        }
    }

    private func getPageItems(forPage page: Int) -> [String] {
        let start = page * pageSize
        let allItems = allItemsForCurrentMode
        let end = min(start + pageSize, allItems.count)
        guard start < end else { return [] }
        return Array(allItems[start..<end])
    }

    func canGoToNextPage() -> Bool {
        return currentPage < totalPages - 1
    }

    func canGoToPreviousPage() -> Bool {
        return currentPage > 0
    }

    func goToNextPage() {
        guard canGoToNextPage() else { return }
        currentPage += 1
        let newItems = getPageItems(forPage: currentPage)
        loadedItems.append(contentsOf: newItems)
    }

    func goToPreviousPage() {
        guard canGoToPreviousPage() else { return }
        currentPage -= 1
        let removeStartIndex = (currentPage + 1) * pageSize
        if removeStartIndex < loadedItems.count {
            loadedItems.removeSubrange(removeStartIndex..<loadedItems.count)
        }
    }

    func switchDisplayMode(to mode: DisplayMode) {
        displayMode = mode
        currentPage = 0
        loadedItems = getPageItems(forPage: currentPage)
    }
}

