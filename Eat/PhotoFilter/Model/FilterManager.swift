//
//  FilterManager.swift
//  Eat
//
//  Created by lu on 2022/1/12.
//

import Foundation

class FilterManager: DataManager {
    func fetch(completionHandler: (_ items: [FilterItem]) -> Void) {
        var items: [FilterItem] = []
        for data in load(file: "FilterData") {
            items.append(FilterItem(dict: data))
        }
        
        completionHandler(items)
    }
}
