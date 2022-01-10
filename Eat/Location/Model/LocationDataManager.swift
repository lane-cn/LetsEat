//
//  LocationDataManager.swift
//  Eat
//
//  Created by lu on 2022/1/4.
//

import Foundation

class LocationDataManager: DataManager {
    private var locations: [LocationItem] = []
    
    func fetch() {
        for dict in loadData() {
            locations.append(LocationItem(dict: dict))
        }
    }
    
    func numberOfItems() -> Int {
        return locations.count
    }
    
    func locationItem(at index: IndexPath) -> LocationItem {
        locations[index.item]
    }

    func findLocation (by name: String) -> (isFound: Bool, position: Int) {
        guard let index = locations.firstIndex(where: { $0.city == name }) else {
            return (isFound: false, position: 0)
        }
        return (isFound: true, position: index)
    }
}

private extension LocationDataManager {
    func loadData() -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: "Locations", ofType: "plist"),
              let items = NSArray(contentsOfFile: path) else {
                  return [[:]]
              }
        return items as! [[String:AnyObject]]
    }
}
