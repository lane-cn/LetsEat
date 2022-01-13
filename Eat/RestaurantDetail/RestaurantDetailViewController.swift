//
//  RestaurantDetailViewController.swift
//  Eat
//
//  Created by lu on 2022/1/10.
//

import UIKit
import MapKit

class RestaurantDetailViewController: UITableViewController {
    
    @IBOutlet weak var btnHeart: UIBarButtonItem!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblCuisine: UILabel!
    @IBOutlet weak var lblHeaderAddress: UILabel!
    @IBOutlet weak var lblTableDetails: UILabel!
    @IBOutlet weak var lblOverallRating: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var imgMap: UIImageView!
    @IBOutlet weak var ratingsView: RatingsView!
    
    var selectedRestaurent: RestaurantItem?

    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        //dump(selectedRestaurent as Any)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier {
            switch Segue(rawValue: identifier) {
            case .showReview:
                showReview(segue: segue)
            default:
                print("segue not set")
            }
        }
    }
    
    func showReview(segue: UIStoryboardSegue) {
        guard let navController = segue.destination as? UINavigationController,
              let viewController = navController.topViewController as? ReviewFormViewController else {
                  return
              }
        viewController.selectedRestaurant = selectedRestaurent
    }

    @IBAction func unwindReviewCancel(segue: UIStoryboardSegue) {
        
    }
}

private extension RestaurantDetailViewController {
    func initialize() {
        setupLabels()
        createMap()
        createRating()
    }
    
    func createRating() {
        ratingsView.rating = 4.5
        ratingsView.isEnabled = true
    }
    
    func setupLabels() {
        guard let restaurant = selectedRestaurent else {
            return
        }
        
        if let name = restaurant.name {
            lblName.text = name
            title = name
        }
        
        if let cuisine = restaurant.subtitle {
            lblCuisine.text = cuisine
        }
        
        if let address = restaurant.address {
            lblAddress.text = address
            lblHeaderAddress.text = address
        }
        
        lblTableDetails.text = "Table for 7, tonight at 10:00 PM"
    }
    
    func createMap() {
        guard let annotation = selectedRestaurent,
              let long = annotation.long,
              let lat = annotation.lat else {
                  return
              }
        
        let location = CLLocationCoordinate2D(latitude: lat, longitude: long)
        takeSnapshot(with: location)
    }
    
    func takeSnapshot(with location: CLLocationCoordinate2D) {
        let mapSnapshotOptions = MKMapSnapshotter.Options()
        var loc = location
        let polyline = MKPolyline(coordinates: &loc, count: 1)
        let region = MKCoordinateRegion(polyline.boundingMapRect)
        mapSnapshotOptions.region = region
        mapSnapshotOptions.scale = UIScreen.main.scale
        mapSnapshotOptions.size = CGSize(width: 340, height: 208)
        mapSnapshotOptions.showsBuildings = true
        mapSnapshotOptions.pointOfInterestFilter = .includingAll
        let snapShoter = MKMapSnapshotter(options: mapSnapshotOptions)
        snapShoter.start(){snapshot, error in
            guard let snapshot = snapshot else {
                return
            }
            UIGraphicsBeginImageContextWithOptions(mapSnapshotOptions.size, true, 0)
            snapshot.image.draw(at: .zero)
            let identifier = "custompin"
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            let pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            pinView.image = UIImage(named: "custom-annotation")!
            let pinImage = pinView.image
            var point = snapshot.point(for: location)
            let rect = self.imgMap.bounds
            if rect.contains(point) {
                let pinCenterOffset = pinView.centerOffset
                point.x -= pinView.bounds.size.width/2
                point.y -= pinView.bounds.size.height/2
                point.x += pinCenterOffset.x
                point.y += pinCenterOffset.y
                pinImage?.draw(at: point)
            }
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                DispatchQueue.main.async {
                    self.imgMap.image = image
                }
            }
        }
    }
}
