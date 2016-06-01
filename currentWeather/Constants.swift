//
//  Constants.swift
//  currentWeather
//
//  Created by Javier Angel on 5/29/16.
//  Copyright © 2016 Iohta Group. All rights reserved.
//

import Foundation

let URL_BASE = "http://api.openweathermap.org/data/2.5/forecast/weather?q="
let API_KEY = "&APPID=7dffcfdcd4f1cc63378b792b85a5d36b"
var currentCity: String!

typealias DownloadComplete = () -> ()


