//
//  islandweather.swift
//  JerseyWweather
//
//  Created by Pister Family on 4/3/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class islandweather: UIViewController {

    @IBOutlet weak var dayview: UIView!
    
    var secondView: UIView?
    //var selectedIsland: String?
    var weatherStations: NSObject?
    
    @IBAction func FlipToWeek(_ sender: Any, forEvent event: UIEvent) {
        flip()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.secondView = UIView(frame: self.view.frame)
        self.secondView?.isHidden = true
        self.secondView?.backgroundColor = .green
        if let v = self.secondView {
            self.view.addSubview(v)
        }
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
