//
//  ViewController.swift
//  WeatherMonkey
//
//  Created by Marko Vukušić on 11/06/2018.
//  Copyright © 2018 Marko Vukušić. All rights reserved.
//

import UIKit
import SwipeCellKit

class CityListController: UITableViewController {
    
    var cities : [String] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storedCities = defaults.array(forKey: "StoredCitiesList") as? [String] {
            cities = storedCities
        }
        
        tableView.rowHeight = 100.0
        
    }
    
    // MARK: - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! SwipeTableViewCell
        
        cell.textLabel?.text = cities[indexPath.row]
        
        cell.delegate = self
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    
    // MARK: - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        performSegue(withIdentifier: "ShowCityWeather", sender: self)

        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! WeatherController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            destinationVC.selectedCity = self.cities[indexPath.row]
        }
     
        
    }
    
    
    // MARK: - Add New Items
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New city?", message: "", preferredStyle: .alert)
        let actionAdd = UIAlertAction(title: "Add", style: .default) { (action) in
            
            let newCity = alert.textFields![0].text!
            
            self.cities.append(newCity)
            
            self.tableView.reloadData()
            
            self.defaults.set(self.cities, forKey: "StoredCitiesList")
            
            
        }
        
        let actionCancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        
        alert.addAction(actionAdd)
        alert.addAction(actionCancel)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Insert new city"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
    
}

// MARK: - Swipable Cells Delegate Methods

extension CityListController : SwipeTableViewCellDelegate {
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            self.cities.remove(at: indexPath.row)
            self.defaults.set(self.cities, forKey: "StoredCitiesList")
            
            self.tableView.reloadData()
        }

        deleteAction.image = UIImage(named: "delete-icon")
        
        return [deleteAction]
    }
    
}

