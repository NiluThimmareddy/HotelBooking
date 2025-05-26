
/*
import Foundation

enum DisplayMode {
    case hotel
    case seasonalPrice
    case policy
    case roomAvailability
}


class HotelJsonViewModel {

    var allHotels: [Hotel] = []
    var allSeasonalPrices: [SeasonalPrice] = []
    var allPolicies: [Policy] = []
    var allRoomAvailability: [RoomAvailability] = []

    var currentItems: [String] = []

    var currentPage = 0
    let pageSize = 10
    var displayMode: DisplayMode = .hotel

    var totalPages: Int {
        switch displayMode {
        case .hotel: return Int(ceil(Double(allHotels.count) / Double(pageSize)))
        case .seasonalPrice: return Int(ceil(Double(allSeasonalPrices.count) / Double(pageSize)))
        case .policy: return Int(ceil(Double(allPolicies.count) / Double(pageSize)))
        case .roomAvailability: return Int(ceil(Double(allRoomAvailability.count) / Double(pageSize)))
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

            currentPage = 0
            paginate()
            completion(true)
        } catch {
            print("JSON decoding failed: \(error)")
            completion(false)
        }
    }

    func paginate() {
        let start = currentPage * pageSize

        switch displayMode {
        case .hotel:
            let end = min(start + pageSize, allHotels.count)
            currentItems = allHotels[start..<end].map {
                "Hotel Name :- \($0.HotelName)\nHotel Type :- \($0.HotelType)"
            }

        case .seasonalPrice:
            let end = min(start + pageSize, allSeasonalPrices.count)
            currentItems = allSeasonalPrices[start..<end].map {
                "Room ID :- \($0.RoomId)\nPrice :- \($0.Price)\nFrom: \($0.StartDate)\nTo: \($0.EndDate)"
            }

        case .policy:
            let end = min(start + pageSize, allPolicies.count)
            currentItems = allPolicies[start..<end].map {
                "Hotel ID :- \($0.HotelId)\nPolicy Type :- \($0.PolicyType)\nDescription :- \($0.Description)"
            }

        case .roomAvailability:
            let end = min(start + pageSize, allRoomAvailability.count)
            currentItems = allRoomAvailability[start..<end].map {
                "Room ID :- \($0.RoomId)\nDate :- \($0.Date)\nAvailable Count :- \($0.AvailableCount)"
            }
        }
    }

    func canGoToNextPage() -> Bool {
        return currentPage < totalPages - 1
    }

    func canGoToPreviousPage() -> Bool {
        return currentPage > 0
    }

    func goToNextPage() {
        if canGoToNextPage() {
            currentPage += 1
            paginate()
        }
    }

    func goToPreviousPage() {
        if canGoToPreviousPage() {
            currentPage -= 1
            paginate()
        }
    }

    func switchDisplayMode(to mode: DisplayMode) {
        displayMode = mode
        currentPage = 0
        paginate()
    }
    
}
*/

import Foundation

enum DisplayMode {
    case hotel
    case seasonalPrice
    case policy
    case roomAvailability
}

class HotelJsonViewModel {

    var allHotels: [Hotel] = []
    var allSeasonalPrices: [SeasonalPrice] = []
    var allPolicies: [Policy] = []
    var allRoomAvailability: [RoomAvailability] = []

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
        }
        return Int(ceil(Double(count) / Double(pageSize)))
    }

    var allItemsForCurrentMode: [String] {
        switch displayMode {
        case .hotel:
            return allHotels.map { "Hotel Name :- \($0.HotelName)\nHotel Type :- \($0.HotelType)" }
        case .seasonalPrice:
            return allSeasonalPrices.map { "Room ID :- \($0.RoomId)\nPrice :- \($0.Price)\nFrom: \($0.StartDate)\nTo: \($0.EndDate)" }
        case .policy:
            return allPolicies.map { "Hotel ID :- \($0.HotelId)\nPolicy Type :- \($0.PolicyType)\nDescription :- \($0.Description)" }
        case .roomAvailability:
            return allRoomAvailability.map { "Room ID :- \($0.RoomId)\nDate :- \($0.Date)\nAvailable Count :- \($0.AvailableCount)" }
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

