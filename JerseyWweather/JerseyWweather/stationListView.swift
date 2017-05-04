//
//  stationListView.swift
//  JerseyWweather
//
//  Created by Pister Family on 4/20/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class stationListView: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var stationList: UITableView!
    var weatherStations: [String: weatherStation]?
    var weatherArray = [String]()
    
    var secondView: UIView?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let stationList = weatherStations {
            for (key, value) in stationList {
                print("\(key) : \(value)")
                self.weatherArray.append(key)
            }
        }
        
        self.stationList.delegate = self
        self.stationList.dataSource = self
        let nib = UINib(nibName: "stationCell", bundle: nil)
        self.stationList.register(nib, forCellReuseIdentifier: "stationCell")
        self.stationList.backgroundColor = .clear
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func flip() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: self.dayview, duration: 1.0, options: transitionOptions, animations: {
            self.dayview.isHidden = true
        })
        
        UIView.transition(with: self.secondView!, duration: 1.0, options: transitionOptions, animations: {
            self.secondView!.isHidden = false
        })
    }
    
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        
        self.secondView = UIView(frame: self.view.frame)
        self.secondView?.isHidden = true
        self.secondView?.backgroundColor = .green
        if let v = self.secondView {
            self.view.addSubview(v)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath) as! stationCell
        
        cell.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.35)
        
        let name = self.weatherArray[indexPath.row]
        
        if let stationList = weatherStations {
            if let value:weatherStation = stationList[name], let weather = value.Weather {
                cell.updateValues(stationName: name, weather: weather)
            }
        }
        
        return cell
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
