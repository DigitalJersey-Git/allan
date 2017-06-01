//
//  detailView.swift
//  JerseyWweather
//
//  Created by Allan Pister on 15/05/2017.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class detailView: UIView {

    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var pressure: UILabel!
    @IBOutlet weak var visibility: UILabel!
    
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var location: UILabel!
    
    let weatherGraphic:[String : String] = ["Cloudy" : "kweather", "Rain" : "weather_showers", "N/A" : "weather_fog"]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func updateView(station: weatherStation, location: String) {
        self.weatherCondition.text = station.Weather
        self.pressure.text = String(station.Pressure!)
        self.visibility.text = station.Visibility
        self.location.text = location
        
        if let name = station.Weather, let gname = weatherGraphic[ name ] {
            self.weatherImage.image = UIImage(named: "\(gname).png")
        }

    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
