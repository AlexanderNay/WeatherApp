//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by AlexanderN on 11.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var backgroundImageCell: UIImageView!
    @IBOutlet weak var mainWeatherImage: UIImageView!
    @IBOutlet weak var dataForecast: UILabel!
    @IBOutlet weak var detailWeather: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    @IBOutlet weak var minTemp: UILabel!
    var isBlurEffectAdded = false
    
    
    func configureCell(forecast: [ForecastStruct], cellRow: Int) {
        if forecast[1].cod != nil {
            //addBlurEffectForCell()
            
            if !isBlurEffectAdded {
                addBlurEffectForCell()
            }
            let correctedData = String(forecast[1].list[cellRow].dt_txt.dropLast(3))
            // dataForecast.text = correctedData  //Add spase between data and time
            
            let test123 = forecast[1].separetedForecast
            print(test123)
            
            dataForecast.text = forecast[1].list[cellRow].weekDay
            detailWeather.text = forecast[1].list[cellRow].weather[0].description.capitalized
            
            let maxTempValue = Int(forecast[1].list[cellRow].main.temp_max - 273)
            if maxTempValue > 0 {
                //maxTemp.text = "+" + String(maxTempValue) + "°"
                maxTemp.text = String(forecast[1].list[cellRow].main.temp_max)
            } else {
                //maxTemp.text = String(maxTempValue) + "°"
                maxTemp.text = String(forecast[1].list[cellRow].main.temp_max)
            }
            
            //maxTemp.text = String(Int(forecast[1].list[cellRow].main.temp_max - 273))
            let minTempValue = Int(forecast[1].list[cellRow].main.temp_min - 273)
            if minTempValue > 0 {
                minTemp.text = "+" + String(minTempValue) + "°"
            } else {
                minTemp.text = String(minTempValue) + "°"
            }
            //minTemp.text = String(Int(forecast[1].list[cellRow].main.temp_min - 273))
            
            backgroundImageCell.image = UIImage(named: forecast[1].list[cellRow].weather[0].description)
            mainWeatherImage.image = UIImage(named: forecast[1].list[cellRow].weather[0].icon)
            
            
            
        }
        //print("CODE CODE = " + forecast.cod)
        //dataForecast.text = forecast[0]
        
        
        
        
        
        
    }
    
    func addBlurEffectForCell() {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = backgroundImageCell.bounds
        blurView.alpha = 0.3
        backgroundImageCell.addSubview(blurView)
        isBlurEffectAdded = true
    }
    
   

}
