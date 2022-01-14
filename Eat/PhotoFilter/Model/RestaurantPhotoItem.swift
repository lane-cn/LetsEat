//
//  RestaurantPhotoItem.swift
//  Eat
//
//  Created by lu on 2022/1/13.
//

import Foundation
import UIKit

struct RestaurantPhotoItem {
    var photo: UIImage?
    var date: Date?
    var restaurantID: Int?
    var uuid = UUID().uuidString
    var photoData: Data {
        guard let image = photo else {
            return Data()
        }
        return Data(image.pngData()!)
    }
}

extension RestaurantPhotoItem {
    init(restaurantPhoto: RestaurantPhoto) {
        self.restaurantID = Int(restaurantPhoto.restaurantID)
        if let restaurantPhoto = restaurantPhoto.photo {
            self.photo = UIImage(data: restaurantPhoto, scale: 1.0)
        }
        if let uuid = restaurantPhoto.uuid {
            self.uuid = uuid
        }
        if let reviewDate = restaurantPhoto.date {
            self.date = reviewDate
        }
    }
}
