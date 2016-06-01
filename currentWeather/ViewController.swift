//
//  ViewController.swift
//  currentWeather
//
//  Created by Javier Angel on 5/28/16.
//  Copyright © 2016 Iohta Group. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import AddressBookUI

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    let geoCoder = CLGeocoder()
    var latitude: CLLocationDegrees!
    var longitude: CLLocationDegrees!
    
    @IBOutlet weak var cityLbl: UILabel!
    
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var weatherOneImg: UIImageView!
    @IBOutlet weak var weatherTwoImg: UIImageView!
    @IBOutlet weak var weatherThreeImg: UIImageView!
    @IBOutlet weak var weatherFourImg: UIImageView!
    @IBOutlet weak var temperatureLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var dayOneLbl: UILabel!
    @IBOutlet weak var dayTwoLbl: UILabel!
    @IBOutlet weak var dayThreeLbl: UILabel!
    @IBOutlet weak var dayFourLbl: UILabel!
    
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var highTempOneLbl: UILabel!
    @IBOutlet weak var highTempTwoLbl: UILabel!
    @IBOutlet weak var highTempThreeLbl: UILabel!
    @IBOutlet weak var highTempFourLbl: UILabel!
    
    @IBOutlet weak var lowTempLbl: UILabel!
    @IBOutlet weak var lowTempOneLbl: UILabel!
    @IBOutlet weak var lowTempTwoLbl: UILabel!
    @IBOutlet weak var lowTempThreeLbl: UILabel!
    @IBOutlet weak var lowTempFourLbl: UILabel!
    
    @IBOutlet weak var windLbl: UILabel!
    @IBOutlet weak var precipitationLbl: UILabel!
    
    var weather = Weather()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestWhenInUseAuthorization()
        
        if (CLLocationManager.locationServicesEnabled()) {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            locationManager.startUpdatingLocation()
        }
        
        
        currentCity = cityLbl.text
        currentCity = weather.location
        print(weather.location)
        
        weather.downloadWeatherDetails { () -> () in
            self.updateUI()
        }

    }
    


    func updateUI() {
        self.temperatureLbl.text = weather.temperature
        self.windLbl.text = weather.wind
        self.precipitationLbl.text = weather.humidity
        self.setTime()
        
        self.highTempLbl.text = weather.high
        self.highTempOneLbl.text = weather.highOne
        self.highTempTwoLbl.text = weather.highTwo
        self.highTempThreeLbl.text = weather.highThree
        self.highTempFourLbl.text = weather.highFour
        
        self.lowTempLbl.text = weather.low
        self.lowTempOneLbl.text = weather.lowOne
        self.lowTempTwoLbl.text = weather.lowTwo
        self.lowTempThreeLbl.text = weather.lowThree
        self.lowTempFourLbl.text = weather.lowFour
        
        self.weatherImg.image = UIImage(named: "\(weather.weatherIcon)")
        self.weatherOneImg.image = UIImage(named: "\(weather.weatherIconOne)")
        self.weatherTwoImg.image = UIImage(named: "\(weather.weatherIconTwo)")
        self.weatherThreeImg.image = UIImage(named: "\(weather.weatherIconThree)")
        self.weatherFourImg.image = UIImage(named: "\(weather.weatherIconFour)")

        
        if dayLbl.text == "Sunday" {
            
            self.dayOneLbl.text = "MON"
            self.dayTwoLbl.text = "TUE"
            self.dayThreeLbl.text = "WED"
            self.dayFourLbl.text = "THU"
            
        } else if dayLbl.text == "Monday" {
            
            self.dayOneLbl.text = "TUE"
            self.dayTwoLbl.text = "WED"
            self.dayThreeLbl.text = "THU"
            self.dayFourLbl.text = "FRI"
            
        } else if dayLbl.text == "Tuesday" {
            
            self.dayOneLbl.text = "WED"
            self.dayTwoLbl.text = "THU"
            self.dayThreeLbl.text = "FRI"
            self.dayFourLbl.text = "SAT"
            
        } else if dayLbl.text == "Wednesday" {
            
            self.dayOneLbl.text = "THU"
            self.dayTwoLbl.text = "FRI"
            self.dayThreeLbl.text = "SAT"
            self.dayFourLbl.text = "SUN"
            
        } else if dayLbl.text == "Thursday" {
            
            self.dayOneLbl.text = "FRI"
            self.dayTwoLbl.text = "SAT"
            self.dayThreeLbl.text = "SUN"
            self.dayFourLbl.text = "MON"
            
        } else if dayLbl.text == "Friday" {
            
            self.dayOneLbl.text = "SAT"
            self.dayTwoLbl.text = "SUN"
            self.dayThreeLbl.text = "MON"
            self.dayFourLbl.text = "TUE"
            
        } else if dayLbl.text == "Saturday" {
            
            self.dayOneLbl.text = "SUN"
            self.dayTwoLbl.text = "MON"
            self.dayThreeLbl.text = "TUE"
            self.dayFourLbl.text = "WED"
            
        } else {
            return
        }
    }
    

    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locValue: CLLocationCoordinate2D = (manager.location?.coordinate)!
        
        let long = locValue.longitude
        let lat = locValue.latitude
        
        self.latitude = lat
        self.longitude = long
        
        reverseGeocoding(lat, longitude: long)
        
    }
    
    
    func reverseGeocoding(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let location = CLLocation(latitude: latitude, longitude: longitude)
        CLGeocoder().reverseGeocodeLocation(location, completionHandler: {(placemarks, error) -> Void in
            if error != nil {
                print(error)
                return
            } else if placemarks?.count > 0 {
                let pm = placemarks![0]
                
                if let city = pm.addressDictionary!["City"] as? String {
                    self.cityLbl.text = city
                    print(city)
                } else {
                    print("No area of Interest")
                }
                               
                if let countryCode = pm.addressDictionary!["CountryCode"] as? String {
                    print(countryCode)
                }
            }
        })
    }
    
    
    func setTime() {
        let currentDate = NSDate()
        let dayDateFormatter = NSDateFormatter()
        let timeDateFormatter = NSDateFormatter()
        let morningEvening = NSDateFormatter()
        dayDateFormatter.dateFormat = "EEEE"
        dayLbl.text = dayDateFormatter.stringFromDate(currentDate)
        timeDateFormatter.dateFormat = "h:mm a"
        timeLbl.text = timeDateFormatter.stringFromDate(currentDate)
        morningEvening.dateFormat = "a"
    }

}

