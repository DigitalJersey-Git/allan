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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = Bundle.main.loadNibNamed("detailView", owner: self, options: nil)?.first as? UIView {
            //self.detailView = view
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
