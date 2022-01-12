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

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onSaveTapped(_ sender: Any) {
        print("score: \(ratingView.rating)")
        print("title: \(tfTitle.text!)")
        print("name: \(tfName.text!)")
        print("rating: \(tfReview.text!)")
        dismiss(animated: true)
    }
}
