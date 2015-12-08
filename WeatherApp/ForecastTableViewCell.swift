//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Griffin Hammer on 12/2/15.
//  Copyright © 2015 Griffin Hammer. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {

    @IBOutlet weak var cellIconImageView: UIImageView!
    @IBOutlet weak var cellLowTempLabel: UILabel!
    @IBOutlet weak var cellHighTempLabel: UILabel!
    @IBOutlet weak var cellDescLabel: UILabel!
    @IBOutlet weak var cellDayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
