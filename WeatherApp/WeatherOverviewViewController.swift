//
//  WeatherOverviewViewController.swift
//  WeatherApp
//
//  Created by Griffin Hammer on 12/2/15.
//  Copyright © 2015 Griffin Hammer. All rights reserved.
//

import UIKit

class WeatherOverviewViewController: UIViewController, UITableViewDataSource {
    
    var forecasts : [Weather]?
    var todayWeather : Weather?
    
    @IBOutlet weak var dayIconImageView: UIImageView!
    
    @IBOutlet weak var dayDateLabel: UILabel!
    @IBOutlet weak var dayDescLabel: UILabel!
    @IBOutlet weak var dayLowTempLabel: UILabel!
    @IBOutlet weak var dayHighTempLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.dataSource = self
        let wsm = WebServiceManager()
        wsm.fetchForecasts{(newForecasts) -> Void in
            self.forecasts = [Weather]()
            for forecast in newForecasts{
                self.forecasts?.append(forecast)
            }
        }
        wsm.fetchWeather({(newWeather) -> Void in
            self.todayWeather = newWeather
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = self.forecasts?.count{
            return count
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let forecast = self.forecasts![indexPath.row]
        
        if let cell = tableView.dequeueReusableCellWithIdentifier("forecastCellReuseID", forIndexPath: indexPath) as? ForecastTableViewCell{
            cell.cellDayLabel.text = forecast.day
            cell.cellDescLabel.text = forecast.desc
            cell.cellHighTempLabel.text = "\(forecast.highTemp!)º"
            cell.cellLowTempLabel.text = "\(forecast.lowTemp!)º"
            cell.cellIconImageView.image = UIImage(named: forecast.icon!)
            
        }
        
        return UITableViewCell()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
