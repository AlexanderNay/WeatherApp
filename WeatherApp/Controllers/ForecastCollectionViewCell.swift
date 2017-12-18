//
//  ForecastCollectionViewCell.swift
//  WeatherApp
//
//  Created by AlexanderN on 11.11.2017.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backgoundImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var iconTypeOfWeather: UIImageView!
    @IBOutlet weak var typeOfWeather: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    
    func setCellsItems(data: SeparatedForecastStruct.BaseDay.PartsOfTheDay) {
        backgoundImage.image = UIImage(named: data.weatherID)
        if data.time == "12:00 AM"{
            timeLabel.text = "00:00 AM"
        } else {
            timeLabel.text = data.time
        }
        
        //iconTypeOfWeather
        iconTypeOfWeather.image = UIImage(named: data.iconTypeOfWeather)
       
        typeOfWeather.text = data.typeOfWeather.capitalized
        temperatureLabel.text = data.upTemperature
        
    }
}
