//
//  ForecastStruct.swift
//  WeatherApp
//
//  Created by AlexanderN on 11.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import Foundation


//TODO: - It should be a struct I think

struct ForecastStruct: Decodable {
    struct List: Decodable {
        struct Main: Decodable {
            var temp: Double!
            var temp_min: Double!
            var temp_max: Double!
            var pressure: Double!
            var see_level: Double!
            var grnd_level: Double!
            var humidity: Int!
            var temp_kf: Double!
        }
        struct Weather: Decodable {
            var id: Int!
            var main: String!
            var description: String!
            var icon: String!
        }
        struct Clouds: Decodable {
            var all: Int!
        }
        struct Wind: Decodable {
            var speed: Double!
            var deg: Double!
        }
        struct Sys: Decodable {
            var pod: String!
        }
        var dt: Int!
        var main: Main!
        var weather: [Weather]!
        var clouds: Clouds!
        var wind: Wind!
        var sys: Sys!
        var dt_txt: String!
        
        var weekDay: String {
            
            return convertDataFromIntervalSince1970ToWeekday(intervalSince1970: dt)
        }
        
        
        
    }
    struct City: Decodable {
        class Coord: Decodable {
            var lat: Double!
            var lon: Double!
        
        }
        var id: Int!
        var name: String!
        var coord: Coord!
        var country: String!
        var population: Int!
        
    }
    
    var cod: String!
    var message: Double!
    var cnt: Int!
    var list: [List]!
    var city: City!
    
    lazy var separetedForecast = getSeparatedForecastsByWeekdays(data: self)

    
     func getSeparatedForecastsByWeekdays ( data: ForecastStruct) -> SeparatedForecastStruct {
        if data != nil {
            
            func temperetureConverterAndSetter(kelvin: Int) -> String {
                let celsiiValue = kelvin - 273
                if celsiiValue > 0 {
                    return  "+" + String(celsiiValue) + "°"
                } else {
                    return String(celsiiValue) + "°"
                }
            }
            
            func converterDateToTime(timeSec: Int) -> String {
                let dateFormater = DateFormatter()
                
                dateFormater.dateStyle = .none
                
                dateFormater.timeStyle = .short
                let timeInterval = TimeInterval(timeSec)
                let date = Date(timeIntervalSince1970: timeInterval)
                let currentDate = dateFormater.string(from: date)
                return currentDate
            }
            
            var separetedStruct = SeparatedForecastStruct()
            var counterDays = 0
            var counterPartsOfDay = 0
            var counterOfIndex = 0
            for index in 0..<self.list.count - 1 {
                
                if data.list[index].weekDay == data.list[index + 1].weekDay {
                    
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].weatherID = String(data.list[index].weather[0].id)
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].upTemperature = temperetureConverterAndSetter(kelvin: Int(data.list[index].main.temp_max))
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].downTemperature = temperetureConverterAndSetter(kelvin: Int(data.list[index].main.temp_min))
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].typeOfWeather = data.list[index].weather[0].description
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].iconTypeOfWeather = data.list[index].weather[0].icon
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].time = converterDateToTime(timeSec: data.list[index].dt)
                    counterPartsOfDay += 1
                    separetedStruct.baseDays[counterDays].partsOfTheDay.append(SeparatedForecastStruct.BaseDay.PartsOfTheDay())
                    
                    
                    
                    print("Days are equal")
                } else {
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].weatherID = String(data.list[index].weather[0].id)
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].upTemperature = temperetureConverterAndSetter(kelvin: Int(data.list[index].main.temp_max))
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].downTemperature = temperetureConverterAndSetter(kelvin: Int(data.list[index].main.temp_min))
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].typeOfWeather = data.list[index].weather[0].description
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].iconTypeOfWeather = data.list[index].weather[0].icon
                    separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].time = converterDateToTime(timeSec: data.list[index].dt)
                    counterPartsOfDay = 0
                    separetedStruct.baseDays[counterDays].weekDay = data.list[index].weekDay
                    counterDays += 1
                    
                    separetedStruct.baseDays.append(SeparatedForecastStruct.BaseDay())
                    print("Day was changed")
                    
                }
                counterOfIndex += 1
                
               
                

            }
            separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].weatherID = String(data.list[counterOfIndex].weather[0].id)
            separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].upTemperature = temperetureConverterAndSetter(kelvin: Int(data.list[counterOfIndex].main.temp_max))
            separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].downTemperature = temperetureConverterAndSetter(kelvin: Int(data.list[counterOfIndex].main.temp_min))
            separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].typeOfWeather = data.list[counterOfIndex].weather[0].description
            separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].iconTypeOfWeather = data.list[counterOfIndex].weather[0].icon
            separetedStruct.baseDays[counterDays].partsOfTheDay[counterPartsOfDay].time = converterDateToTime(timeSec: data.list[counterOfIndex].dt)
            separetedStruct.baseDays[counterDays].weekDay = data.list[counterOfIndex].weekDay
            
            return separetedStruct
        } else {
            return SeparatedForecastStruct()
        }
    }
    
    
    func getForecastData(forecastWeatherURL: String, completed: @escaping (_ data: ForecastStruct)->()) {
       
        guard let url = URL(string: forecastWeatherURL) else { return print("***Error") }
        

       URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return print("****Error") }
            do {
                var dataForecast = try JSONDecoder().decode(ForecastStruct.self, from: data)
  
                DispatchQueue.main.async { //?????
                    //completed(dataForecast.city.name)
                    completed(dataForecast)
                    print("___2___ getForecastData \(dataForecast.separetedForecast)")
                }
                
                
            } catch let jsonError {
                print("************Error serialezing json: ", jsonError)
                
            }
            }.resume()
    }

    
    
    
}















