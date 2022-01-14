//
//  PhotoViewController.swift
//  Eat
//
//  Created by htlu on 2022/1/14.
//

import UIKit

class PhotoViewController: UIViewController {
    @IBOutlet var collectionView: UICollectionView!
    //var selectedRestaurant: RestaurantItem?
    var photos: [RestaurantPhotoItem] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkPhotos()
    }
}

private extension PhotoViewController {
    func initialize() {
        setupCollectionView()
    }

    func setupCollectionView() {
        let flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7)
        flow.minimumInteritemSpacing = 0
        flow.minimumLineSpacing = 7
        flow.scrollDirection = .horizontal
        collectionView.collectionViewLayout = flow
    }

    func checkPhotos() {
        let viewController: RestaurantDetailViewController = self.parent as! RestaurantDetailViewController
        if let id: Int = viewController.selectedRestaurent?.restaurantID {
            photos = CoreDataManager.shared.fetchPhoto(by: id)
            if photos.count > 0 {
                collectionView.backgroundView = nil
            } else {
                let view = NoDataView(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: collectionView.frame.height))
                view.set(title: "Reviews")
                view.set(desc: "There are currently no reviews")
                collectionView.backgroundView = view
            }
        }
        collectionView.reloadData()
    }
}

extension PhotoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "photoCell", for: indexPath) as! PhotoCell
        let photo = photos[indexPath.item]
        if let img = photo.photo {
            cell.imgReview.image = img
        }
        return cell
    }
    
}

extension PhotoViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let offset: Float = photos.count == 1 ? 14 : 21
        let width = collectionView.frame.size.width - CGFloat(offset)
        return CGSize(width: width, height: 200)
    }
}
