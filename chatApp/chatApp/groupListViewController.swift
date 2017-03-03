//
//  groupListViewController.swift
//  chatApp
//
//  Created by Allan Pister on 28/02/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

class groupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupTableView: UITableView!
    
    private var channels: [SBDOpenChannel] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the list of channels and join one.
        self.createOpenChannel()
    }
    
    func createOpenChannel() {
        let query = SBDOpenChannel.createOpenChannelListQuery()
        query?.limit = 1
        
        query?.loadNextPage(completionHandler: {[unowned self]
            (channels, error) in
            if error != nil {
                NSLog("Error: %@", error!)
                return
            }
            
            for channel in channels! {
                self.channels.append(channel)
            }
            
            DispatchQueue.main.async {
                self.groupTableView.reloadData()
            }
            // ...
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This will be the number of rows returned in the query.
        return self.channels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "groupCell", for: indexPath)
        
        (cell as! groupCell).setCellInfo(aChannel: self.channels[indexPath.row])
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "membersListViewController") {
            let membersController = (segue.destination as! membersListViewController)
            membersController.channel = channels.first
        }
    }

}
