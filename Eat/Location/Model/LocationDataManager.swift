//
//  LocationDataManager.swift
//  Eat
//
//  Created by htlu on 2022/1/4.
//

import Foundation

class LocationDataManager: DataManager {
    private var locations: [String] = []
    
    func fetch() {
        for location in load(file: "Locations") {
            if let city = location["city"] as? String,
               let state = location["state"] as? String {
                locations.append("\(city), \(state)")
            }
        }
    }
    
    func numberOfItems() -> Int {
        return locations.count
    }
    
    func locationItem(at index: IndexPath) -> String {
        locations[index.item]
    }
}
