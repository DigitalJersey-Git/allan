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
    var weatherStations: NSObject?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let wDic = weatherStations as! NSDictionary
        for ws in wDic {
            print("key : \(ws)")
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (weatherStations as! NSDictionary).count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath) as! stationCell
        
        cell.backgroundColor = UIColor(colorLiteralRed: 0.0, green: 0.0, blue: 0.0, alpha: 0.35)
    
        let wDic = weatherStations as! NSDictionary
        
        if let w = wDic.object(forKey: <#T##Any#>) {
            print(" WTYPE: " + (w as! String))
        }
        
        //cell.updateValues(stationName: <#T##String#>, weather: <#T##String#>)
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
