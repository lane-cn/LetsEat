//
//  ExploreDataManager.swift
//  Eat
//
//  Created by lu on 2022/1/3.
//

import Foundation

class ExploreDataManager: DataManager {
    
    fileprivate var items: [ExploreItem] = []
    
    func numberOfItems() -> Int {
        items.count
    }
    
    func explore(at index: IndexPath) -> ExploreItem {
        items[index.item]
    }
    
    func fetch() {
        for data in load(file: "ExploreData") {
            //print("data: \(data)")
            items.append(ExploreItem(dict: data))
        }
    }
}
