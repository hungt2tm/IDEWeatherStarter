//
//  ViewController.swift
//  WeatherStarter
//
//  Created by If Only on 3/4/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//
// http://www.pinsdaddy.com/weather-iphone-background_WvDD1MkwIac6pMWOOD3jtfk7QSgXqgZf2zPe6jb5n6o/2

import UIKit
import Alamofire

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var weather: Weather?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.dataSource = self
        let backgroundView = UIImageView(image: #imageLiteral(resourceName: "background"))
        self.tableView.backgroundView = backgroundView
        self.getDataByAlamofire()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getDataByAlamofire() {
        if let url = URL(string: "https://api.darksky.net/forecast/30f33c181d865817a7c0d087f7891b01/21.0277644,105.8341598") {
            Alamofire.request(url).responseJSON(completionHandler: { [weak self] (response) in
                guard let strongSelf = self else { return }
                if let value = response.result.value as? JSONData {
                    strongSelf.weather = Weather(jsonData: value)
                    strongSelf.tableView.reloadData()
                }
            })
        }
    }
    
    func getData() {
        if let url = URL(string: "https://api.darksky.net/forecast/30f33c181d865817a7c0d087f7891b01/21.0277644,105.8341598") {
            do {
                let data = try Data(contentsOf: url)
                if let jsonData = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? JSONData {
                    self.weather = Weather(jsonData: jsonData)
                }
            } catch {
                print("Can't get data")
            }
        }
    }


}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var identifier: String
        switch indexPath.section {
        case 1:
            identifier = "hourlyCell"
        case 2:
            identifier = "dailyCell"
        default:
            identifier = "currentCell"
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if identifier == "currentCell" {
            let temperatureLabel = cell.viewWithTag(100) as! UILabel
            let cityLabel = cell.viewWithTag(200) as! UILabel
            let summaryLabel = cell.viewWithTag(300) as! UILabel
            
            temperatureLabel.backgroundColor = .clear
            cityLabel.backgroundColor = .clear
            summaryLabel.backgroundColor = .clear
            
            temperatureLabel.text = "\(Utility.convertToCelsius(fahrenheit: self.weather?.currentlyWeatherInfo.temperature ?? 0))°C"
            cityLabel.text = self.weather?.city
            summaryLabel.text = self.weather?.currentlyWeatherInfo.summary ?? ""
            
        } else if identifier == "hourlyCell" {
            if let cell = cell as? HourlyTableViewCell {
                cell.hourlyWeatherInfo = self.weather?.hourlyWeatherInfo
                cell.collectionView.reloadData()
            }
            
        } else if identifier == "dailyCell" {
            let dayLabel = cell.viewWithTag(600) as! UILabel
            let temperatureMinLabel = cell.viewWithTag(700) as! UILabel
            let temperatureMaxLabel = cell.viewWithTag(800) as! UILabel
            
            dayLabel.backgroundColor = .clear
            temperatureMinLabel.backgroundColor = .clear
            temperatureMaxLabel.backgroundColor = .clear
            
            let dailyInfo = self.weather?.dailyWeatherInfo[indexPath.row]
            dayLabel.text = Utility.convertTimeIntervalToString(time: (dailyInfo?.time ?? 0), format: "EEEE")
            temperatureMinLabel.text = "\(Utility.convertToCelsius(fahrenheit: dailyInfo?.temperatureMin ?? 0))"
            temperatureMaxLabel.text = "\(Utility.convertToCelsius(fahrenheit: dailyInfo?.temperatureMax ?? 0))"
        }
        
        
        return cell
    }
}







