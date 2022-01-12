//
//  FilterItem.swift
//  Eat
//
//  Created by lu on 2022/1/12.
//

import Foundation

class FilterItem: NSObject {
    let filter: String
    let name: String
    
    init(dict: [String: AnyObject]) {
        name = dict["name"] as! String
        filter = dict["filter"] as! String
    }
}
