//
//  ViewController.swift
//  WeatherMonkey
//
//  Created by Marko Vukušić on 11/06/2018.
//  Copyright © 2018 Marko Vukušić. All rights reserved.
//

import UIKit

class CityListController: UITableViewController {
    
    let cityArray = ["Split", "London", "Peckham"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    //MARK - Tableview Datasource Methods
        
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

}

