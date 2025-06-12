

import Foundation

enum DisplayMode {
    case hotel, seasonalPrice, policy, roomAvailability, hotelRooms, hotelImages
}

class HotelJsonViewModel {

    var allHotels: [Hotel] = []
    var allSeasonalPrices: [SeasonalPrice] = []
    var allPolicies: [Policy] = []
    var allRoomAvailability: [RoomAvailability] = []
    var allRooms: [HotelRoom] = []
    var allhotelImages: [HotelImage] = []
    
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
            return allRooms.map { $0.roomId }
        case .hotelImages:
            return allhotelImages.map { "Hotel ID: \($0.hotelId) \nImageUrl: \($0.imageUrl)\nImageId: \($0.imageId)" }
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

