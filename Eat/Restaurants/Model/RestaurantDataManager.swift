//
//  RestaurantDataManager.swift
//  Eat
//
//  Created by lu on 2022/1/10.
//

import Foundation

class RestaurantDataManager {
    private var items: [RestaurantItem] = []
    
    func fetch(by location: String, with filter: String = "All", completeHandler: (_ items: [RestaurantItem]) -> Void) {
        if let file = Bundle.main.url(forResource: location, withExtension: "json") {
            do {
                let data = try Data(contentsOf: file)
                let restaurents = try JSONDecoder().decode([RestaurantItem].self, from: data)
                if filter != "All" {
                    items = restaurents.filter({$0.cuisines.contains(filter)})
                } else {
                    items = restaurents
                }
            } catch {
                print("There was an error: \(error)")
            }
        }
        completeHandler(items)
    }
    
    func numberOfItems() -> Int {
        items.count
    }
    
    func restaurantItem(at index: IndexPath) -> RestaurantItem {
        items[index.item]
    }
}
