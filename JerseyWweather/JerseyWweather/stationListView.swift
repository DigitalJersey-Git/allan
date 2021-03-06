//
//  stationListView.swift
//  JerseyWweather
//
//  Created by Pister Family on 4/20/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit
import MapKit

class stationListView: UIViewController, UITableViewDataSource, UITableViewDelegate, MKMapViewDelegate {

    var detailView: detailView?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stationList: UITableView!

    
    var weatherStations: [String : weatherStation]?
    var weatherArray = [String]()
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationController?.navigationBar.backItem?.leftBarButtonItem = UIBarButtonItem(
            title: "Continue",
            style: .plain,
            target: self,
            action: #selector(self.flip(sender:)))
    }
    
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
        
        if let view = Bundle.main.loadNibNamed("detailView", owner: self, options: nil)?.first as? detailView {
            self.detailView = view
            self.detailView?.isHidden = true
            
            let navHeight = (self.navigationController?.navigationBar.bounds.height)! + UIApplication.shared.statusBarFrame.size.height
            view.frame = CGRect(x: 0, y: navHeight, width: self.view.frame.width, height: self.view.frame.height - navHeight)
            
            self.view.addSubview(view)
        }
    }
    /*
    func flip(sender: Any) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: self.tableView, duration: 1.0, options: transitionOptions, animations: {
            self.tableView.isHidden = true
        })
        
        UIView.transition(with: self.detailView!, duration: 1.0, options: transitionOptions, animations: {
            self.detailView!.isHidden = false
        })
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let name = self.weatherArray[indexPath.row]
        
        if let stationList = weatherStations {
            if let value:weatherStation = stationList[name] {
                self.detailView?.updateView(station: value, location: name, controller: self)
            }
        }
        
        self.flip(sender: "hi")
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

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        print("DEST : \(segue.destination)")
    }
    
    /*FLIP ANIMATION---------------------------------------------------------------------------------------------------------*/
    
    
    
    func flip(sender: Any) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        
        UIView.transition(with: self.tableView, duration: 1.0, options: transitionOptions, animations: {
            self.tableView.isHidden = true
        })
        
        UIView.transition(with: self.detailView!, duration: 1.0, options: transitionOptions, animations: {
            self.detailView!.isHidden = false
            
            self.navigationItem.hidesBackButton = true
            let flipBackButton = UIBarButtonItem(title: "Weather Locations", style: .plain, target: self, action: #selector(stationListView.flipBack(sender:)))
            self.navigationItem.leftBarButtonItem = flipBackButton
        })
    }
    
    func flipBack(sender: Any) {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromLeft, .showHideTransitionViews]
        
        UIView.transition(with: self.tableView, duration: 1.0, options: transitionOptions, animations: {
            self.tableView.isHidden = false
        })
        
        UIView.transition(with: self.detailView!, duration: 1.0, options: transitionOptions, animations: {
            self.detailView!.isHidden = true
            
            let flipBackButton = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(stationListView.backToRoot(sender:)))
            self.navigationItem.leftBarButtonItem = flipBackButton
            self.navigationItem.hidesBackButton = true
        })
    }
    
    
    /*NAVIGATION BACK BUTTON CUSTOMISATION---------------------------------------------------------------------------------------------------------*/
    
    func backToRoot(sender:UIBarButtonItem){
        
        _ = navigationController?.popViewController(animated: true)
        
    }

}
