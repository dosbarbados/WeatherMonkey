//
//  ViewController.swift
//  WeatherMonkey
//
//  Created by Marko Vukušić on 11/06/2018.
//  Copyright © 2018 Marko Vukušić. All rights reserved.
//

import UIKit

class CityListController: UITableViewController {
    
    var cityArray = ["Split", "London", "Peckham"]
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let storedCities = defaults.array(forKey: "cityList") as? [String] {
            cityArray = storedCities
        }
        
        
    // MARK - Tableview Datasource Methods
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
 
        let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath)
        
        cell.textLabel?.text = cityArray[indexPath.row]
        
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityArray.count
    }

    
    //MARK - Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    //MARK - Add New Items
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "New City", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (action) in
            
            if let newCity = alert.textFields?[0].text {
                self.cityArray.append(newCity)
                
                self.tableView.reloadData()
                
                self.defaults.set(self.cityArray, forKey: "cityList")
            }
            
        }
        
        alert.addAction(action)
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Insert new city"
        }
        
        present(alert, animated: true, completion: nil)
        
    }
    
}

