//
//  LocationViewController.swift
//  Eat
//
//  Created by lu on 2022/1/4.
//

import UIKit

class LocationViewController: UIViewController {
        
    @IBOutlet weak var tableView: UITableView!
    
    let manager = LocationDataManager()
    var selectedCity: LocationItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    func set(selected cell: UITableViewCell, at indexPath: IndexPath) {
        if let city = selectedCity?.city {
            let data = manager.findLocation(by: city)
            if data.isFound {
                if indexPath.row == data.position {
                    cell.accessoryType = .checkmark
                } else {
                    cell.accessoryType = .none
                }
            }
        } else {
            cell.accessoryType = .none
        }
    }
}

private extension LocationViewController {
    func initialize() {
        manager.fetch()
        self.title = "Select a location"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        manager.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let locationItem = manager.locationItem(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "locationCell", for: indexPath)
        cell.textLabel?.text = locationItem.full
        set(selected: cell, at: indexPath)
        //cell.tag = locationItem.city
        return cell
    }
}

extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            selectedCity = manager.locationItem(at: indexPath)
            tableView.reloadData()
        }
    }
}
