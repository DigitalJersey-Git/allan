//
//  ViewController.swift
//  JerseyWweather
//
//  Created by Pister Family on 3/30/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class weatherStation: NSObject {
    var wind: String?
    var Gust: String?
    var Visibility: String?
    var Weather: String?
    var Pressure: Int?
    var Tendency: String?
    
    override init() {
        super.init()
    }
}

class ViewController: UIViewController, XMLParserDelegate  {
    
    @IBOutlet weak var stationList: UIButton!
    @IBOutlet weak var mylocation: UIButton!
    
    var selectedIsland: String?
    var xmlData: String?
    var weatherReports = [String: weatherStation]()
    var currentStation: weatherStation?
    var foundCharacters: String = String()
    
    @IBAction func weatherLocBPush(_ sender: Any) {
        let Btn = sender as! UIButton
        self.setSelectedIs(sender: Btn)
        self.performSegue(withIdentifier: "stationListSegue", sender: self)
    }
    
    @IBAction func myLocationBPush(_ sender: Any) {
        let Btn = sender as! UIButton
        self.setSelectedIs(sender: Btn)
        self.performSegue(withIdentifier: "islandweatherSegue", sender: self)
    }
    
    func setSelectedIs(sender: UIButton) {
        if let lbl = sender.titleLabel {
            selectedIsland = lbl.text
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        if let path = Bundle.main.path(forResource: "jerseymet", ofType: "xml") {
            let fm = FileManager()
            let exists = fm.fileExists(atPath: path)
            if (exists) {
                if let c = fm.contents(atPath: path) {
                    xmlData = String(bytes: c, encoding: String.Encoding.utf8)
                    if let xdata = xmlData?.data(using: String.Encoding.utf8) {
                        let parser = XMLParser(data: xdata)
                        parser.delegate = self
                        print("Result: \(parser.parse())")
                    }
                }
            }
        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if (elementName as String) == "StationReport" {
            self.currentStation = weatherStation()
            if let key = attributeDict["Name"], self.currentStation != nil {
                weatherReports.updateValue(self.currentStation!, forKey: key)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
        if self.currentStation != nil {
            let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            
            if (!data.isEmpty) {
                self.foundCharacters += data
            }
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        print(elementName)
        let lowerText = elementName.lowercased()
        switch(lowerText) {
            case "wind":
                self.currentStation?.wind = self.foundCharacters
            case "gust":
                self.currentStation?.Gust = self.foundCharacters
            case "visibility":
                self.currentStation?.Visibility = self.foundCharacters
            case "weather":
                self.currentStation?.Weather = self.foundCharacters
            case "pressure":
                self.currentStation?.Pressure = Int(self.foundCharacters)
            case "tendency":
                self.currentStation?.Tendency = self.foundCharacters
            default:
                print(self.foundCharacters)
        }
        
        self.foundCharacters = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch segue.identifier! {
            case "islandweatherSegue":
                if let nextController = segue.destination as? islandweather {
                    //nextController.selectedIsland = self.selectedIsland
                }
            case "stationListSegue":
                if let nextController = segue.destination as? stationListView {
                    nextController.weatherStations = self.weatherReports as NSObject
                }
            default:
                return
        }
    }
}
