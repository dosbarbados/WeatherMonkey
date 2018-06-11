//
//  WetherController.swift
//  WeatherMonkey
//
//  Created by Marko Vukušić on 11/06/2018.
//  Copyright © 2018 Marko Vukušić. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import SDWebImage

class WeatherController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let WEATHER_URL = "http://api.worldweatheronline.com/premium/v1/weather.ashx"
    let APIKEY = "a50e9ee8652548f7a96192627181106"
    
    var fiveDayWeather : [Weather]? = []
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cityLabel: UILabel!
    
    var selectedCity : String? {
        didSet {
            fetchWeatherData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }

    // MARK: - Read weather data
    
    func fetchWeatherData() {
        
        let param : [String : String] = ["q" : selectedCity!,
                                         "format" : "json",
                                         "num_of_days" : "5",
                                         "key" : APIKEY]
        Alamofire.request(WEATHER_URL, method: .get, parameters: param).responseJSON {
            response in
            
            if response.result.isSuccess {
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeather(json: weatherJSON)
                
            } else {
                print("Cannot access data from API")
            }
            
        }
    }
    
    // MARK: - Update screen data
    
    func updateWeather(json: JSON) {
        
        cityLabel.text = selectedCity
        
        let imageURL = json["data"]["current_condition"][0]["weatherIconUrl"][0]["value"].stringValue
        self.imageView.sd_setImage(with: URL(string: imageURL))
        
        for index in 0...4 {
            
            let weather = Weather()
            weather.date = json["data"]["weather"][index]["date"].stringValue
            weather.maxTemp = json["data"]["weather"][index]["maxtempC"].intValue
            weather.minTemp = json["data"]["weather"][index]["mintempC"].intValue
            
            fiveDayWeather?.append(weather)
        
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Table data methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        if let weather = fiveDayWeather?[indexPath.row] {
            cell.textLabel?.text = "\(weather.date) : \(weather.minTemp)°C - \(weather.maxTemp)°C"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = fiveDayWeather?.count {
            return count
        } else {
            return 0
        }
    }

}


