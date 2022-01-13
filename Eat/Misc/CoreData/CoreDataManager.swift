//
//  CoreDataManager.swift
//  Eat
//
//  Created by lu on 2022/1/13.
//

import Foundation
import CoreData

struct CoreDataManager {
    let container: NSPersistentContainer
    
    init() {
        container = NSPersistentContainer(name: "LetsEatModel")
        container.loadPersistentStores { storeDescription, error in
            print("load persistentStore \(storeDescription)")
            error.map{print($0)}
        }
    }
    
    func addReview(_ item: ReviewItem) {
        let review = Review(context: container.viewContext)
        review.name = item.name
        review.title = item.title
        review.date = Date()
        if let rating = item.rating {
            review.rating = rating
        }
        review.customerReview = item.customerReview
        review.uuid = item.uuid
        if let id = item.restaurantID {
            review.restaurantID = Int32(id)
            save()
        }
    }
    
    func addPhoto(_ item: RestaurantPhotoItem) {
        let photo = RestaurantPhoto(context: container.viewContext)
        photo.uuid = item.uuid
        photo.photo = item.photoData
        photo.date = Date()
        if let id = item.restaurantID {
            photo.restaurantID = Int32(id)
            save()
        }
    }
    
    func fetchReviews(by restaurantID: Int) -> [ReviewItem] {
        let ctx = container.viewContext
        let request: NSFetchRequest<Review> = Review.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(restaurantID))
        var items: [ReviewItem] = []
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        do {
            for review in try ctx.fetch(request) {
                items.append(ReviewItem(review: review))
            }
            return items
        } catch {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
    func fetchPhoto(by restaurantID: Int) -> [RestaurantPhotoItem] {
        let ctx = container.viewContext
        let request: NSFetchRequest<RestaurantPhoto> = RestaurantPhoto.fetchRequest()
        let predicate = NSPredicate(format: "restaurantID = %i", Int32(restaurantID))
        var items: [RestaurantPhotoItem] = []
        request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
        request.predicate = predicate
        do {
            for photo in try ctx.fetch(request) {
                items.append(RestaurantPhotoItem(restaurantPhoto: photo))
            }
            return items
        } catch {
            fatalError("Failed to fetch reviews: \(error)")
        }
    }
    
    func save() {
        do {
            if container.viewContext.hasChanges {
                try container.viewContext.save()
            }
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}

extension CoreDataManager {
    static var shared = CoreDataManager()
}
