//
//  DataManager.swift
//  WeatherApp
//
//  Created by Griffin Hammer on 12/2/15.
//  Copyright © 2015 Griffin Hammer. All rights reserved.
//

import Foundation


struct DataManager {
    static let sharedManager = DataManager()
    
    func saveWeather(forecasts:[Forecast]){
        
    }
    
    func loadWeather() -> [Forecast]? {
        var forecasts = [Forecast]()
        
        for var i = 0; i < 10; i++ {
            var f = Forecast()
            f.day = "1430326800"
            f.highTemp = 53
            f.lowTemp = 41
            f.icon  = "10n"
            forecasts.append(f)
        }
        return forecasts
    }
    
    private func filePathForArchiving() -> String {
        let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let destinationPath = "\(documentsPath)/SavedForecasts"
        return destinationPath
    }
    
    func saveForecasts(forecasts:[Forecast]){
        let destinationPath = self.filePathForArchiving()
        NSKeyedArchiver.archiveRootObject(forecasts, toFile: destinationPath)
    }
    
    func loadForecasts() -> [Forecast]? {
        let destinationPath = self.filePathForArchiving()
        
        if let forecasts : [Forecast] = NSKeyedUnarchiver.unarchiveObjectWithFile(destinationPath) as? [Forecast] {
            return forecasts
        }
        
        return [Forecast]()
    }
}