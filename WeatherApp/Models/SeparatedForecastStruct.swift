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

//TODO: - If Struct will be nil

extension SeparatedForecastStruct: CustomStringConvertible {
    var description: String {
        var pPrinter = "Start"
        for i in 0..<baseDays.count {
            let pWeekDay = "\n\(baseDays[i].weekDay)"
            pPrinter += pWeekDay
            for j in 0..<baseDays[i].partsOfTheDay.count {
                let pTime = "\n\(baseDays[i].partsOfTheDay[j].time)"
                let pTypeOfWeather = " \(baseDays[i].partsOfTheDay[j].typeOfWeather)"
                let pUpTemperature = " \(baseDays[i].partsOfTheDay[j].upTemperature)"
                pPrinter = pPrinter + pTime + pTypeOfWeather + pUpTemperature
            }
        }
        pPrinter += "\nFinish"

       return pPrinter
        /*
         Friday
         3:00 AM  Light Snow -2
         6:00 AM  Light Snow -1
         ...
         Saturday
         00:00 AM  Light Rain +1
         3:00 AM  Light Rain +1
 */
    }
    
    
}
