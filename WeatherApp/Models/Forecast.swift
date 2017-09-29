//
//  Forecast.swift
//  WeatherApp
//
//  Created by AlexanderN on 11.09.17.
//  Copyright © 2017 AlexanderN. All rights reserved.
//

import Foundation

class Forecast {
    
    private var _date: String!
    private var _whetherMainType: String!
    private var _whetherDetailType: String!
    private var _highTemp: Int!
    private var _lowTemp: Int!
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var whetherMainType: String {
        if _whetherMainType == nil {
            _whetherMainType = ""
        }
        return _whetherMainType
    }
    
    var whetherDetailType: String {
        if _whetherDetailType == nil {
            _whetherDetailType = ""
        }
        return _whetherDetailType
    }
    
    var highTemp: String {
        if _highTemp == nil {
            _highTemp = -99
        }
        return String(_highTemp)
    }
    
    var lowTemp: String {
        if _lowTemp == nil {
            _lowTemp = -99
        }
        return String(_lowTemp)
    }
    
    
}



