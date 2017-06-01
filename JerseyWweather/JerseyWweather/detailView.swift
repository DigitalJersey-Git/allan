//
//  detailView.swift
//  JerseyWweather
//
//  Created by Allan Pister on 15/05/2017.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit
import MapKit

class detailView: UIView {

    @IBOutlet weak var mapView: MKMapView!
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
    
    func updateView(station: weatherStation, location: String, controller: MKMapViewDelegate) {
        self.mapView.delegate = controller
        self.weatherCondition.text = station.Weather
        self.pressure.text = String(station.Pressure!)
        self.visibility.text = station.Visibility
        self.location.text = location
        
        if let name = station.Weather, let gname = weatherGraphic[ name ] {
            self.weatherImage.image = UIImage(named: "\(gname).png")
        }
        
        self.moveToLocation(point: CGPoint(x: 50.881672185016924, y: -2.59552001953125))
    }
    
    func moveToLocation(point: CGPoint) {
        let batmanCenterCoordinate = CLLocationCoordinate2DMake(CLLocationDegrees(point.x), CLLocationDegrees(point.y))
        var region: MKCoordinateRegion = MKCoordinateRegion()
        region.center = batmanCenterCoordinate//self.mapView.userLocation.coordinate
        
        var span: MKCoordinateSpan = MKCoordinateSpan()
        span.latitudeDelta  = 5 // Change these values to change the zoom
        span.longitudeDelta = 5
        region.span = span

        self.mapView.setRegion(region, animated: true)
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
