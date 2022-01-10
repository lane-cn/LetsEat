//
//  LocationItem.swift
//  Eat
//
//  Created by lu on 2022/1/10.
//

import Foundation

struct LocationItem {
    var city: String?
    var state: String?
}

extension LocationItem {
    init(dict: [String: AnyObject]) {
        self.city = dict["city"] as? String
        self.state = dict["state"] as? String
    }
    
    var full: String {
        guard let city = self.city,
              let state = self.state else {
                  return ""
              }
            
        return "\(city), \(state)"
    }
}
