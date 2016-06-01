//
//  Weather.swift
//  currentWeather
//
//  Created by Javier Angel on 5/28/16.
//  Copyright © 2016 Iohta Group. All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class Weather {
    private var _location: String!
    private var _temperature: String!
    private var _day: String!
    private var _time: String!
    private var _high: String!
    private var _highOne: String!
    private var _highTwo: String!
    private var _highThree: String!
    private var _highFour: String!
    private var _low: String!
    private var _lowOne: String!
    private var _lowTwo: String!
    private var _lowThree: String!
    private var _lowFour: String!
    private var _wind: String!
    private var _humidity: String!
    private var _weatherUrl: String!
    private var _weatherIcon: String!
    private var _weatherIconOne: String!
    private var _weatherIconTwo: String!
    private var _weatherIconThree: String!
    private var _weatherIconFour: String!
    
    
    var location: String {
        get {
            if _location == nil {
                return ""
            }
            return _location
        }
    }
    
    var temperature: String {
        get {
            if _temperature == nil {
                return ""
            }
            return _temperature
        }
    }
    
    var high: String {
        get {
            if _high == nil {
                return ""
            }
            return _high
        }
    }
    
    var highOne: String {
        get {
            if _highOne == nil {
                return ""
            }
            return _highOne
        }
    }
    
    var highTwo: String {
        get {
            if _highTwo == nil {
                return ""
            }
            return _highTwo
        }
    }
    
    var highThree: String {
        get {
            if _highThree == nil {
                return ""
            }
            return _highThree
        }
    }
    
    var highFour: String {
        get {
            if _highFour == nil {
                return ""
            }
            return _highFour
        }
    }
    
    var low: String {
        get {
            if _low == nil {
                return ""
            }
            return _low
        }
    }
    
    var lowOne: String {
        get {
            if _lowOne == nil {
                return ""
            }
            return _lowOne
        }
    }
    
    var lowTwo: String {
        get {
            if _lowTwo == nil {
                return ""
            }
            return _lowTwo
        }
    }
    
    var lowThree: String {
        get {
            if _lowThree == nil {
                return ""
            }
            return _lowThree
        }
    }
    
    var lowFour: String {
        get {
            if _lowFour == nil {
                return ""
            }
            return _lowFour
        }
    }
    
    var wind: String {
        get {
            if _wind == nil {
                return ""
            }
            return _wind
        }
    }
    
    var humidity: String {
        get {
            if _humidity == nil {
                return "0%"
            }
            return _humidity
        }
    }
    
    var weatherUrl: String {
        get {
            if _weatherUrl == nil {
                return ""
            }
            return _weatherUrl
        }
    }
    
    var weatherIcon: String {
        get {
            if _weatherIcon == nil {
                return ""
            }
            return _weatherIcon
        }
    }
    
    var weatherIconOne: String {
        get {
            if _weatherIconOne == nil {
                return ""
            }
            return _weatherIconOne
        }
    }
    
    var weatherIconTwo: String {
        get {
            if _weatherIconTwo == nil {
                return ""
            }
            return _weatherIconTwo
        }
    }
    
    var weatherIconThree: String {
        get {
            if _weatherIconThree == nil {
                return ""
            }
            return _weatherIconThree
        }
    }
    
    var weatherIconFour: String {
        get {
            if _weatherIconFour == nil {
                return ""
            }
            return _weatherIconFour
        }
    }
    
    init() {
        _weatherUrl = "\(URL_BASE)LosAngeles\(API_KEY)"
    }
    
    func downloadWeatherDetails(completed: DownloadComplete) {
        
        let url = NSURL(string: _weatherUrl)!
        Alamofire.request(.GET, url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                print(result.value)
                print(self._weatherUrl)
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = list[0]["main"] as? Dictionary<String, Int> {
                        
                        if let temperature = main["temp"] {
                            self._temperature = "\((Int(Double(temperature) * (9/5) - (459.67))))°"
                        }
                        
                        if let high = main["temp_max"] {
                            self._high = "\((Int(Double(high) * (9/5) - (459.67))))°"
                        }
                        
                        if let low = main["temp_min"] {
                            self._low = "\((Int(Double(low) * (9/5) - (459.67))))°"
                        }

                    }
                    
                    if let wind = list[0]["wind"] as? Dictionary<String, Double> {
                        
                        if let speed = wind["speed"] {
                            self._wind = "\(speed) MPH"
                        }
                    }
                    
                    if let rain = list[0]["rain"] as? Dictionary<String, Double> {
                        
                        if let lastThree = rain["3h"] {
                            self._humidity = "\(lastThree * 100)%"
                        }
                    }
                    
                    if let weather = list[0]["weather"] as? [Dictionary<String, AnyObject>] {
                        
                        if let icon = weather[0]["icon"] {
                            self._weatherIcon = "\(icon)"
                        }
                    }
                    
                    print(self._temperature)
                    print(self._high)
                    print(self._low)
                    print(self._wind)
                    print(self._weatherIcon)
                }
                
                if let listOne = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = listOne[1]["main"] as? Dictionary<String, Int> {
                        
                        if let high = main["temp_max"] {
                            self._highOne = "\((Int(Double(high) * (9/5) - (459.67))))°"
                        }
                        
                        if let low = main["temp_min"] {
                            self._lowOne = "\((Int(Double(low) * (9/5) - (459.67))))°"
                        }
                    }
                    
                    if let weather = listOne[1]["weather"] as? [Dictionary<String, AnyObject>] {
                        
                        if let icon = weather[0]["icon"] {
                            self._weatherIconOne = "\(icon)"
                        }
                    }
                    
                    print(self._highOne)
                    print(self._lowOne)
                    print(self._weatherIconOne)
                    
                }
                
                if let listTwo = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = listTwo[2]["main"] as? Dictionary<String, Int> {
                        
                        if let high = main["temp_max"] {
                            self._highTwo = "\((Int(Double(high) * (9/5) - (459.67))))°"
                        }
                        
                        if let low = main["temp_min"] {
                            self._lowTwo = "\((Int(Double(low) * (9/5) - (459.67))))°"
                        }
                    }
                    
                    if let weather = listTwo[2]["weather"] as? [Dictionary<String, AnyObject>] {
                        
                        if let icon = weather[0]["icon"] {
                            self._weatherIconTwo = "\(icon)"
                        }
                    }
                    
                    print(self._highTwo)
                    print(self._lowTwo)
                    print(self._weatherIconTwo)
                    
                }
                
                if let listThree = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = listThree[3]["main"] as? Dictionary<String, Int> {
                        
                        if let high = main["temp_max"] {
                            self._highThree = "\((Int(Double(high) * (9/5) - (459.67))))°"
                        }
                        
                        if let low = main["temp_min"] {
                            self._lowThree = "\((Int(Double(low) * (9/5) - (459.67))))°"
                        }
                    }
                    
                    if let weather = listThree[3]["weather"] as? [Dictionary<String, AnyObject>] {
                        
                        if let icon = weather[0]["icon"] {
                            self._weatherIconThree = "\(icon)"
                        }
                    }
                    
                    print(self._highThree)
                    print(self._lowThree)
                    print(self._weatherIconThree)
                    
                }
                
                if let listFour = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    if let main = listFour[4]["main"] as? Dictionary<String, Int> {
                        
                        if let high = main["temp_max"] {
                            self._highFour = "\((Int(Double(high) * (9/5) - (459.67))))°"
                        }
                        
                        if let low = main["temp_min"] {
                            self._lowFour = "\((Int(Double(low) * (9/5) - (459.67))))°"
                        }
                    }
                    
                    if let weather = listFour[4]["weather"] as? [Dictionary<String, AnyObject>] {
                        
                        if let icon = weather[0]["icon"] {
                            self._weatherIconFour = "\(icon)"
                        }
                    }
                    
                }
            }
            completed()
        }
    }
}
