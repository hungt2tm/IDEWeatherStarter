//
//  Weather.swift
//  WeatherStarter
//
//  Created by If Only on 3/4/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//

import Foundation

struct Weather {
    var city: String = "Hà Nội"
    var currentlyWeatherInfo: WeatherInfo
    var hourlyWeatherInfo: [WeatherInfo] = [WeatherInfo]()
    var dailyWeatherInfo: [DailyInfo] = [DailyInfo]()
    
    init?(jsonData: JSONData) {
        guard let currently = jsonData["currently"] as? JSONData else { return nil }
        guard let hourly = jsonData["hourly"] as? JSONData else { return nil }
        guard let daily = jsonData["daily"] as? JSONData else { return nil }
        
        guard let currentlyWeatherInfo = WeatherInfo(jsonData: currently) else{ return nil }
        self.currentlyWeatherInfo = currentlyWeatherInfo
        
        if let hourlyData = hourly["data"] as? [JSONData] {
            for data in hourlyData {
                if let weatherInfo = WeatherInfo(jsonData: data) {
                    self.hourlyWeatherInfo.append(weatherInfo)
                }
                if self.hourlyWeatherInfo.count > 23 { break }
            }
        }
        
        if let dailyData = daily["data"] as? [JSONData] {
            for data in dailyData {
                if let dailyInfo = DailyInfo(jsonData: data) {
                    self.dailyWeatherInfo.append(dailyInfo)
                }
            }
        }
        
    }
}

