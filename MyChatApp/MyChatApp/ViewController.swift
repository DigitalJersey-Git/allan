//
//  ViewController.swift
//  MyChatApp
//
//  Created by Pister Family on 2/20/17.
//  Copyright © 2017 MulgaKittyProductions. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

    @IBOutlet weak var imageLogo: UIImageView!
    @IBOutlet weak var signInName: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func butonSelected(_ sender: Any) {
        
        if signInName.text != "" {
            performSegue(withIdentifier: "signInSegue", sender: nil)
            defaults.set(signInName.text, forKey: "username")
        } else {
            //let alertController = UIAlertController(title: "Error", message: "Please enter a username before proceeding", preferredStyle: UIAlertControllerStyle.alert)
            
            //let cancelActoin = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel) {
                
            //}
            
        }
    }

}

