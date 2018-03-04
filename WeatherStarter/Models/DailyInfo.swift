//
//  DailyInfo.swift
//  WeatherStarter
//
//  Created by If Only on 3/5/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//

import Foundation

struct DailyInfo {
    var time: TimeInterval
    var temperatureMin: Double
    var temperatureMax: Double
    
    init?(jsonData: JSONData) {
        guard let time = jsonData["time"] as? TimeInterval else { return nil }
        guard let temperatureMin = jsonData["temperatureMin"] as? Double else { return nil }
        guard let temperatureMax = jsonData["temperatureMax"] as? Double else { return nil }
        
        self.time = time
        self.temperatureMin = temperatureMin
        self.temperatureMax = temperatureMax
    }
}
