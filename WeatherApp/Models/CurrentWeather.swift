//
//  DataCenter.swift
//  WeatherApp
//
//  Created by AlexanderN on 07.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import Foundation

class CurrentWeather {
    private var _cityName: String!
    private var _date: String!
    private var _weatherMainType: String!
    private var _weatherDetailType: String!
    private var _iconNameForCurrentWeather: String!
    private var _currentTemp: Int!
    private var _currentWeatherID: Int!  // Check do we need this or not
    var task: URLSessionDataTask?
    
    var cityName: String {
        if _cityName == nil {
            _cityName = "Error"
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {  // Does it make sense here?
            _date = ""
        }
        
        let dateFormater = DateFormatter()
        dateFormater.dateStyle = .long
        dateFormater.timeStyle = .none
        let currentDate = dateFormater.string(from: Date())
        self._date = currentDate
        return _date
    }
    
    var weaherMainType: String {
        if _weatherMainType == nil {
            _weatherMainType = "Error"
        }
        return _weatherMainType
    }
    
    var whetherDetailType: String {
        if _weatherDetailType == nil {
            _weatherDetailType = "Error"
        }
        return _weatherDetailType
    }
    
    var iconNameForCurrentWeather: String {
        if _iconNameForCurrentWeather == nil {
            _iconNameForCurrentWeather = "Error"
        }
        return _iconNameForCurrentWeather
    }
    
    var currentTemp: String {
        if _currentTemp == nil {
            _currentTemp = -99
        }
        let tempInCelcius = _currentTemp - 273
        if tempInCelcius > 0 {
          return "+" + String(tempInCelcius) + "°"
        } else {
            return String(tempInCelcius) + "°"
        }
        
    }
    
    var currentWeatherID: Int {
        if _currentWeatherID == nil {
            _currentWeatherID = 0
        }
        return _currentWeatherID
    }
    
    let defaultSession = URLSession(configuration: .default)
    
    func getDataFromUrl(completed: @escaping ()->()) {
        let url = URL(string: currentLinkURL)!
        task = defaultSession.dataTask(with: url) { (data, response, error) in
            defer {
                self.task = nil
            }
            if let error = error {
                print("DataTask error: " + error.localizedDescription + "\n")
            } else if  let data = data , let response = response as? HTTPURLResponse, response.statusCode == 200 {
                self.updateResults(data)
                
                print("###### Data task default session ###### \(self.cityName)")
                DispatchQueue.main.async {
                    completed()
                }
                
            }
        }
        print("###### Data task default session222 ###### \(self.cityName)")
        
        task?.resume()
        
        
        
    }
    
    typealias JSONDictionary = [String : Any]
    func updateResults (_ data: Data) {
        var response: JSONDictionary?
        do {
            response = try JSONSerialization.jsonObject(with: data, options: []) as? JSONDictionary
        } catch let parseError as NSError {
            print("JSONSerrualezation error: \(parseError.localizedDescription)")
            return
        }
        print("___1___ updateResults")
        print(response)
        guard let arrayOfWeather = response!["weather"] as? [Any] else {
            print("Dictionary does not contain wheather key")
            return
        }
        if let weatherDictionary = arrayOfWeather[0] as? [String : Any] {
            if let weatherDesctiption = weatherDictionary["description"] as? String,
               let weatherMain = weatherDictionary["main"] as? String,
               let weatherIcon = weatherDictionary["icon"] as? String,
               let weatherID = weatherDictionary["id"] as? Int {  //Check will you use it or not
            
                self._weatherDetailType = weatherDesctiption
                self._weatherMainType = weatherMain
                self._iconNameForCurrentWeather = weatherIcon
                self._currentWeatherID = weatherID
                
            print("%%%%%%%%%%%%% \(self._weatherDetailType) \n \(self._weatherMainType) \n \(self._iconNameForCurrentWeather) \n \(self._currentWeatherID) \n %%%%%%%%%")
            }
        } else {
            print("Error with parsing branch weather")
        }
        if let cityName = response!["name"] as? String {
            self._cityName = cityName
            print(self._cityName)
            print(self.cityName)
        } else {
            print("Error with parsing branch name")
        }
        guard let dictionaryMain = response!["main"] as? [String : Any] else {
            print("Dictionary does not contain weather key or it has type issue")
            return
        }
        if let currentTemp = dictionaryMain["temp"] as? Double {
            self._currentTemp = Int(currentTemp)
            print(self._currentTemp)
            print(self.currentTemp)
        }
        
    }
    
    
    
}
