//
//  WebServiceManager.swift
//  WeatherApp
//
//  Created by Griffin Hammer on 12/2/15.
//  Copyright © 2015 Griffin Hammer. All rights reserved.
//

import Foundation

struct WebServiceManager {
    
    
    private func parseWeather(jsonDict : [String:AnyObject]) -> Weather{
        var newWeather = Weather()
        if let tempDict = jsonDict["temp"] as? [String : AnyObject]{
            newWeather.highTemp = tempDict["max"] as? Int
            newWeather.lowTemp = tempDict["min"] as? Int
        }else{
            newWeather.highTemp = 110
            newWeather.lowTemp = 10
        }
        if let weatherDict = jsonDict["weather"] as? [String: AnyObject]{
            newWeather.desc = weatherDict["rain"] as? String
            newWeather.icon = weatherDict["icon"] as? String
        }
        if let timeResult = (jsonDict["dt"] as? Double) {
            let dateObj = NSDate(timeIntervalSince1970: timeResult)
            let dateFormatter : NSDateFormatter = NSDateFormatter()
            dateFormatter.dateFormat = "MMM dd"
            newWeather.day = dateFormatter.stringFromDate(dateObj)
        }
        return newWeather
        
    }

    
    
    func fetchForecasts(callback : ([Weather]) -> Void){
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast?q=Atlanta&mode=json&APPID=1d04e62091eabb4695bb6e9993976418")
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){ data, response, err in
            if err == nil {
                //Processing code goes here
                var WeatherList = [Weather]()
                do{
                    if let jsonArray : [ [String : AnyObject] ] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [[String : AnyObject] ]{
                        for jsonDict in jsonArray{
                            let newWeather = self.parseWeather(jsonDict)
                            for var i = 0; i < 10; i++ {
                                WeatherList.append(newWeather)
                            }
                        }
                        callback(WeatherList)
                    }
                }
                catch{
                    //We got an error
                    callback([])
                }
            }
            else {
                //Got an erro, so print it out
                print("Got an error: \(err)")
            }
        }
        task.resume()
    }
    
    func fetchWeather(callback : (Weather) -> Void){
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/weather?q=Atlanta&units=imperial&APPID=1d04e62091eabb4695bb6e9993976418")
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){ data, response, err in
            if err == nil {
                do{
                    if let jsonResult : [ [String : AnyObject] ] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [[String: AnyObject]]{
                        for jsonDict in jsonResult{
                            let newWeather = self.parseWeather(jsonDict)
                            callback(newWeather)
                        }
                       
                    }
                }
                catch{
                    callback(Weather())
                }
            }
            else{
                print("Got an error: \(err)")
            }
        }
        task.resume()
    }
    
}