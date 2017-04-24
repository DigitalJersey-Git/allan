//
//  stationcellTableViewCell.swift
//  JerseyWweather
//
//  Created by Pister Family on 4/20/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class stationCell: UITableViewCell {

    @IBOutlet weak var weatherValue: UILabel!
    @IBOutlet weak var NameValue: UILabel!
    @IBOutlet weak var timeValue: UILabel!
    
    func updateValues(stationName: String, weather: String) {
        //self.timeValue =
        self.NameValue.text = stationName
        self.weatherValue.text = weather
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
