//
//  TabBarController.swift
//  chatApp
//
//  Created by Allan Pister on 06/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

class TabBarController: UITabBarController, protoCurrentChannel {
    
    var channel: SBDOpenChannel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let viewlist = self.viewControllers {
            for view in viewlist {
                //if view is groupListViewController {
                if let dest = view as? groupListViewController {
                    // 2. Set self as a value to delegate
                    dest.delegate = self
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setCurrentChannel(currentChannel: SBDOpenChannel) {
        self.channel = currentChannel
    }
    
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        print("Selected \(self.tabBarController?.selectedIndex)")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(segue.identifier)
        
        if segue.identifier == "signInSegue" {
            if let nextViewController = segue.destination as? groupListViewController {
                // 2. Set self as a value to delegate
                nextViewController.delegate = self
            }
        }
    }
    

}
