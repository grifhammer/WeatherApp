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
    
    
    func loadForecasts() -> [Weather]? {
        var forecasts = [Weather]()
        
        for var i = 0; i < 10; i++ {
            var w = Weather()
            w.day = "1430326800"
            w.highTemp = 53
            w.lowTemp = 41
            w.icon  = "10n"
            forecasts.append(w)
        }
        
        return forecasts
    }
    
}