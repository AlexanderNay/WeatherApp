//
//  SeparatedForecastStruct.swift
//  WeatherApp
//
//  Created by AlexanderN on 09.11.2017.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import Foundation

struct SeparatedForecastStruct {
    var baseDays: [BaseDay] = [BaseDay()]
    
    struct BaseDay {
        var partsOfTheDay: [PartsOfTheDay] = [PartsOfTheDay()]
        var weekDay = ""
        
        struct PartsOfTheDay {
            var time = ""
            var typeOfWeather = ""
            var upTemperature = ""
            var downTemperature = ""
            var iconTypeOfWeather = ""
        }
    }
}
