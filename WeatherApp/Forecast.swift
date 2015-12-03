//
//  Forecast.swift
//  WeatherApp
//
//  Created by Griffin Hammer on 12/2/15.
//  Copyright © 2015 Griffin Hammer. All rights reserved.
//

import Foundation

class Forecast : NSObject, NSCoding {
    var icon : String?
    var highTemp : Int?
    var lowTemp : Int?
    var desc : String?
    var day : String?
    
    @objc required init?(coder aDecoder: NSCoder) {
        self.icon = aDecoder.decodeObjectForKey("icon") as? String
        self.highTemp = aDecoder.decodeObjectForKey("highTemp") as? Int
        self.lowTemp = aDecoder.decodeObjectForKey("lowTemp") as? Int
        self.desc = aDecoder.decodeObjectForKey("desc") as? String
        self.day = aDecoder.decodeObjectForKey("day") as? String
    }
    
    override init(){
        super.init()
    }
    
    @objc func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.lowTemp, forKey: "lowTemp")
        aCoder.encodeObject(self.highTemp, forKey: "highTemp")
        aCoder.encodeObject(self.icon, forKey: "icon")
        aCoder.encodeObject(self.desc, forKey: "desc")
        aCoder.encodeObject(self.day, forKey: "day")
    }

}