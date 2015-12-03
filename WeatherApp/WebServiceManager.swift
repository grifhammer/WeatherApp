//
//  WebServiceManager.swift
//  WeatherApp
//
//  Created by Griffin Hammer on 12/2/15.
//  Copyright © 2015 Griffin Hammer. All rights reserved.
//

import Foundation

struct WebServiceManager {
    func fetchForecasts(callback : ([Forecast]) -> Void){
        let url = NSURL(string: "http://api.openweathermap.org/data/2.5/forecast/daily?q=Atlanta,ga&mode=json&cnt=5&units=imperial&APPID=1d04e62091eabb4695bb6e9993976418")
        let request = NSURLRequest(URL: url!)
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request){ data, response, err in
            if err == nil {
                //Processing code goes here
                var forecastList = [Forecast]()
                do{
                    if let jsonArray : [ [String : AnyObject] ] = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as? [[String : AnyObject] ]{
                        for jsonDict in jsonArray{
                            let newForecast = self.parseForecast(jsonDict["list"])
                            for var i = 0; i < 10; i++ {
                                forecastList.append(newForecast)
                            }
                        }
                        callback(forecastList)
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
    
    private func parseForecast(jsonDict : [String:AnyObject]) -> Forecast{
        let newForecast = Forecast()
        
        newForecast.highTemp = jsonDict["temp"]
        newForecast.lowTemp = jsonDict["temp"]
    }
}