//
//  ViewController.swift
//  JerseyWweather
//
//  Created by Pister Family on 3/30/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var JerseyClick: UIButton!
    @IBOutlet weak var GuernseyClick: UIButton!
    
    var selectedIsland: String?
    
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
        
        // Do any additional setup after loading the view, typically from a nib.
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
