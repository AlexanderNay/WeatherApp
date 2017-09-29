//
//  ForecastStruct.swift
//  WeatherApp
//
//  Created by AlexanderN on 11.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import Foundation

class ForecastStruct: Decodable {
    class List: Decodable {
        class Main: Decodable {
            var temp: Double!
            var temp_min: Double!
            var temp_max: Double!
            var pressure: Double!
            var see_level: Double!
            var grnd_level: Double!
            var humidity: Int!
            var temp_kf: Double!
        }
        class Weather: Decodable {
            var id: Int!
            var main: String!
            var description: String!
            var icon: String!
        }
        class Clouds: Decodable {
            var all: Int!
        }
        class Wind: Decodable {
            var speed: Double!
            var deg: Double!
        }
        class Sys: Decodable {
            var pod: String!
        }
        var dt: Int!
        var main: Main!
        var weather: [Weather]!
        var clouds: Clouds!
        var wind: Wind!
        var sys: Sys!
        var dt_txt: String!
    }
    class City: Decodable {
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
    
    
    func getForecastData(completed: @escaping (_ data: ForecastStruct)->()) {
       
        guard let url = URL(string: forecastLinkURL) else { return print("***Error") }
        

       URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return print("****Error") }
            do {
                let dataForecast = try JSONDecoder().decode(ForecastStruct.self, from: data)
            //    print("\n \n ********** \n ********** \n")
            //    print("The city is " + dataForecast.city.name)
            //    print("The detailWeather is " + dataForecast.list[0].weather[0].description)
            //    print("The CODE is " + dataForecast.cod)
                DispatchQueue.main.async { //?????
                    //completed(dataForecast.city.name)
                    completed(dataForecast)
                }
                
                
            } catch let jsonError {
                print("************Error serialezing json: ", jsonError)
            }
            }.resume()
    }

    
    
    
}















