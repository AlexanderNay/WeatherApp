//
//  Constants.swift
//  WeatherApp
//
//  Created by AlexanderN on 08.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import Foundation


let systemLanguage = String(describing: Locale.current.languageCode!)

let latitude = "55.75"  // 55.75  49.28
let longitude = "37.61"  // 37.61   -123.13
let id_Main_id = "92e10328812e8ab73443258f102a6a84"
var currentLinkURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&lang=\(systemLanguage)&APPID=92e10328812e8ab73443258f102a6a84"
//https://api.openweathermap.org/data/2.5/weather?lat=55.75&lon=37.61&APPID=92e10328812e8ab73443258f102a6a84

var forecastLinkURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&lang=\(systemLanguage)&APPID=92e10328812e8ab73443258f102a6a84"

//https://api.openweathermap.org/data/2.5/forecast/daily?lat=55.75&lon=37.61&APPID=92e10328812e8ab73443258f102a6a84

// Test Location Name







func generaterURL(id: String, latitude: Double, longitude: Double, systemLanguage: String) -> (currentURL: String, forecastURL: String){
    let currentWeatherURL = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&lang=\(systemLanguage)&APPID=\(id)"
    let forecastWeatherURL = "https://api.openweathermap.org/data/2.5/forecast?lat=\(latitude)&lon=\(longitude)&lang=\(systemLanguage)&APPID=\(id)"
    return (currentWeatherURL, forecastWeatherURL)
}



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


