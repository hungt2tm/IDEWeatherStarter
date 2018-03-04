//
//  String+Extension.swift
//  WeatherStarter
//
//  Created by If Only on 3/4/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//

import Foundation

class Utility {
    static func convertToCelsius(fahrenheit: Double) -> Int {
        return Int(5.0 / 9.0 * (fahrenheit - 32.0))
    }
    
    static func convertTimeIntervalToString(time: TimeInterval, format: String) -> String {
        let date = Date(timeIntervalSince1970: time)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
}
