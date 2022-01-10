//
//  ExploreDataManager.swift
//  Eat
//
//  Created by htlu on 2022/1/3.
//

import Foundation

class ExploreDataManager {
    
    fileprivate var items: [ExploreItem] = []
    
    func numberOfItems() -> Int {
        return items.count
    }
    
    func explore(at index: IndexPath) -> ExploreItem {
        return items[index.item]
    }
    
    func fetch() {
        for data in loadData() {
            //print("data: \(data)")
            items.append(ExploreItem(dict: data))
        }
    }
    
    fileprivate func loadData() -> [[String: AnyObject]] {
        guard let path = Bundle.main.path(forResource: "ExploreData", ofType: "plist"),
              let items = NSArray(contentsOfFile: path) else {
                  return [[:]]
        }
        return items as! [[String: AnyObject]]
    }
}
