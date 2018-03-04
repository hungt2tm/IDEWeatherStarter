//
//  HourlyTableViewCell.swift
//  WeatherStarter
//
//  Created by If Only on 3/4/18.
//  Copyright © 2018 Gnuh Nav Inc. All rights reserved.
//

import UIKit

class HourlyTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var hourlyWeatherInfo: [WeatherInfo]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.dataSource = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension HourlyTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.hourlyWeatherInfo?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .clear
        
        if let timeLabel = cell.viewWithTag(400) as? UILabel,
        let time = self.hourlyWeatherInfo?[indexPath.item].time
        {
            timeLabel.text = Utility.convertTimeIntervalToString(time: time, format: "H a")
        }
        
        if let temperatureLabel = cell.viewWithTag(500) as? UILabel {
            temperatureLabel.text = "\(Utility.convertToCelsius(fahrenheit: self.hourlyWeatherInfo?[indexPath.row].temperature ?? 0))°C"
        }
        
        return cell
    }
}

