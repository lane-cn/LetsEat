//
//  LocationViewController.swift
//  Eat
//
//  Created by htlu on 2022/1/4.
//

import UIKit

class LocationViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    let manager = LocationDataManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
}

private extension LocationViewController {
    func initialize() {
        manager.fetch()
    }
}

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let text = manager.locationItem(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = "\(text) \(indexPath.item)"
        return cell
    }
}
