//
//  ViewController.swift
//  JerseyWweather
//
//  Created by Pister Family on 3/30/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

let saveData = UserDefaults.standard

class weatherStation: NSObject {
    var wind: String?
    var Gust: String?
    var Visibility: String?
    var Weather: String?
    var Pressure: Int?
    var Tendency: String?
    var longLat: (log: Double, Lat: Double)?
    
    override init() {
        super.init()
    }
}

class ViewController: UIViewController, XMLParserDelegate, UIPickerViewDelegate, UIPickerViewDataSource  {
    
    @IBOutlet weak var touchExample: UIButton!
    @IBOutlet weak var stationList: UIButton!
    @IBOutlet weak var mylocation: UIButton!
    @IBOutlet weak var locationPicker: UIPickerView!
    
    @IBOutlet weak var stack: UIStackView!
    @IBOutlet weak var navHeader: UINavigationItem!
    
    var selectedIsland: String?
    var xmlData: String?
    var weatherReports = [String: weatherStation]()
    var currentStation: weatherStation?
    var foundCharacters: String = String()
    var pickerData:[String] = [String]()
    var locationSelected: String?
    
    
    @IBAction func touchExample(_ sender: Any) {
        if let view = Bundle.main.loadNibNamed("touchExample", owner: self, options: nil)?.first as? touchExample {
            self.navigationController?.pushViewController(view, animated: true)
        }
    }
    
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
    
        if self.view.bounds.size.width <= 480 {
            stack.axis = .vertical
            stack.spacing = 15
        }
        
        
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
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        self.locationPicker.delegate = self
        self.locationPicker.dataSource = self
        self.locationPicker.backgroundColor = UIColor.clear
        
        for (key, value) in self.weatherReports {
            print("\(key) : \(value)")
            self.pickerData.append(key)
        }
        
        
        if let loc:Int = saveData.value(forKey: "locationSelected") as? Int {
            self.locationPicker.selectRow(loc, inComponent: 0, animated: true)
            self.locationSelected = self.pickerData[loc]
        }
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
            case "Location":
                var list = self.foundCharacters.components(separatedBy: ",")
                if list.count == 2 {
                    //self.currentStation?.longLat = (Double: list[0], Double: list[1])
                }
            default:
                print(self.foundCharacters)
        }
        
        self.foundCharacters = ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.locationSelected = self.pickerData[row]
        saveData.set(row, forKey: "locationSelected")
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
                    nextController.weatherStations = self.weatherReports
                    nextController.myLocation = self.locationSelected ?? self.pickerData.first
                }
            case "stationListSegue":
                print("DEST : \(segue.destination)")
                if let nextController = segue.destination as? stationListView {
                    nextController.weatherStations = self.weatherReports
                }
            default:
                return
        }
    }
}
