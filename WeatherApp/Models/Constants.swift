//
//  Constants.swift
//  WeatherApp
//
//  Created by AlexanderN on 08.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import Foundation

let languageString = String(describing: Locale.current.languageCode!)

let latitiude = "55.75"  // 55.75  49.28
let longitude = "37.61"  // 37.61   -123.13
var currentLinkURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitiude)&lon=\(longitude)&lang=\(languageString)&APPID=92e10328812e8ab73443258f102a6a84"
//https://api.openweathermap.org/data/2.5/weather?lat=55.75&lon=37.61&APPID=92e10328812e8ab73443258f102a6a84

var forecastLinkURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitiude)&lon=\(longitude)&lang=\(languageString)&APPID=92e10328812e8ab73443258f102a6a84"

//https://api.openweathermap.org/data/2.5/forecast/daily?lat=55.75&lon=37.61&APPID=92e10328812e8ab73443258f102a6a84







func convertDataFromIntervalSince1970ToWeekday (intervalSince1970: Int) -> String {
    let dateFormater = DateFormatter()
    
    dateFormater.dateStyle = .short
    //dateFormater.weekdaySymbols
    dateFormater.timeStyle = .none
    let timeInterval = TimeInterval(intervalSince1970)
    let date = Date(timeIntervalSince1970: timeInterval)
    //let currentDate = dateFormater.string(from: date)
    //let weekday = Calendar.current.component(.weekday, from: date)
    let weekdayName = dateFormater.weekdaySymbols[Calendar.current.component(.weekday, from: date) - 1]
    
    
    return weekdayName
}


