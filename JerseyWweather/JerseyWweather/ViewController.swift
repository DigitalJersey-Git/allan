//
//  ViewController.swift
//  JerseyWweather
//
//  Created by Pister Family on 3/30/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class station: NSObject {
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
    
    @IBOutlet weak var JerseyClick: UIButton!
    @IBOutlet weak var GuernseyClick: UIButton!
    
    var selectedIsland: String?
    var xmlData: String?
    var weatherReport = [String: station]()
    
    @IBAction func GuernesyBPush(_ sender: Any) {
        let Btn = sender as! UIButton
        self.setSelectedIs(sender: Btn)
        self.performSegue(withIdentifier: "islandweatherSegue", sender: self)
    }
    
    @IBAction func jerseyBPush(_ sender: Any) {
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
            let newstation = station()
            if let key = attributeDict["Name"] {
                weatherReport.updateValue(newstation, forKey: key)
            }
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if segue.identifier == "islandweatherSegue" {
            if let nextController = segue.destination as? islandweather {
                nextController.selectedIsland = self.selectedIsland
            }
        }
    }
}
