//
//  ViewController.swift
//  chatApp
//
//  Created by Allan Pister on 25/02/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

class ViewController: UIViewController  {

    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var userID: String?
    var userName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userID = defaults.string(forKey: "userID")
        self.userName = defaults.string(forKey: "username")
        print("read: \(self.userID) - \(userName)")
        userNameField.text = userName
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func randomString(_ length: Int) -> String? {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
    }
    
    @IBAction func buttonSelected(_ sender: Any) {
        
        if userNameField.text == nil || userNameField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter a username before proceeding", preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.cancel, handler: { action in
                //self.pressed()
            })
            
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
            return
        }
            
        // If the user name fields are not the same then reset the user ID
        if (userNameField.text != self.userName) {
            
            self.userID = userNameField.text! + "-"
            
            if let randomS = randomString(10) {
                self.userID?.append(randomS)
            }
            
            // Save the new user ID and Name
            defaults.set(self.userID, forKey: "userID")
            defaults.set(userNameField.text, forKey: "username")
            defaults.synchronize()
        }
        
        
        //if let userid = self.userID, let username = userNameField.text {
        guard let userid = self.userID, let username = userNameField.text else {
            print("error")
            return
        }
        
        // Connect to sendbird.
        SBDMain.connect(withUserId: userid, completionHandler: { [unowned self]
            (user, error) in
            
            // Display error and return if it could not get any data from the service.
            if error != nil {
                let vc = UIAlertController(title: "Error", message: "Problem creating channel", preferredStyle: UIAlertControllerStyle.alert)
                let closeAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: { (action) in
                    self.dismiss(animated: false, completion: nil)
                })
                vc.addAction(closeAction)
                DispatchQueue.main.async {
                    self.present(vc, animated: true, completion: nil)
                }
                return;
            }
            
            // Update the user name and profile.
            SBDMain.updateCurrentUserInfo(withNickname: username, profileImage: nil, completionHandler: { (error) in
                // Not checking anything here.
            })
            
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "signInSegue", sender: self)
            }
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("\(segue.identifier)")
    }
    
}

