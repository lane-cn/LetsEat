//
//  ReviewFormViewController.swift
//  Eat
//
//  Created by lu on 2022/1/12.
//

import UIKit

class ReviewFormViewController: UITableViewController {
    
    @IBOutlet weak var ratingView: RatingsView!
    @IBOutlet weak var tfTitle: UITextField!
    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfReview: UITextView!
    var selectedRestaurant: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        //print(selectedRestaurant?.restaurantID as? Any)
    }

}

private extension ReviewFormViewController {
    @IBAction func onSaveTapped(_ sender: Any) {
        var item = ReviewItem()
        item.name = tfName.text
        item.title = tfTitle.text
        item.customerReview = tfReview.text
        item.restaurantID = selectedRestaurant?.restaurantID
        item.rating = Double(ratingView.rating)
        CoreDataManager.shard.addReview(item)
//        dismiss(animated: true, completion: nil)
//        print("score: \(ratingView.rating)")
//        print("title: \(tfTitle.text!)")
//        print("name: \()")
//        print("rating: \(tfReview.text!)")
        dismiss(animated: true)
    }

}
