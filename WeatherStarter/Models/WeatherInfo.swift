//
//  WeatherInfo.swift
//  WeatherStarter
//
//  Created by If Only on 3/4/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//

import Foundation

struct WeatherInfo {
    var time: TimeInterval
    var summary: String
    var temperature: Double
    
    init?(jsonData: JSONData) {
        guard let time = jsonData["time"] as? TimeInterval else { return nil }
        guard let summary = jsonData["summary"] as? String else { return nil }
        guard let temperature = jsonData["temperature"] as? Double else { return nil }
        
        self.time = time
        self.summary = summary
        self.temperature = temperature
    }
}
