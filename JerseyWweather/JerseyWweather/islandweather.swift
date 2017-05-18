//
//  islandweather.swift
//  JerseyWweather
//
//  Created by Pister Family on 4/3/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class islandweather: UIViewController {

    var weatherStations: [String: weatherStation]?
    var myLocation: String?
    var detailView: UIView?
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = Bundle.main.loadNibNamed("detailView", owner: self, options: nil)?.first as? UIView {
            if let stationList = weatherStations, let loc = myLocation {
                if let ws = stationList[loc] {
                    (view as! detailView).updateView(station: ws, location: loc)
                }
            }
            
            self.view.addSubview(view)
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
