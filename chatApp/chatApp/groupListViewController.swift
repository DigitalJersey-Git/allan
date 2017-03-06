//
//  groupListViewController.swift
//  chatApp
//
//  Created by Allan Pister on 28/02/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

protocol protoCurrentChannel: class {
    func setCurrentChannel(currentChannel: SBDOpenChannel)
}

class groupListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var groupTableView: UITableView!
    
    private var channels: [SBDOpenChannel] = []
    
    weak var delegate:protoCurrentChannel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Get the list of channels and join one.
        self.createOpenChannel()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createOpenChannel() {
        let query = SBDOpenChannel.createOpenChannelListQuery()
        query?.limit = 2
        
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
                if let channel = self.channels.first {
                    self.delegate?.setCurrentChannel(currentChannel: channel)
                }
            }
            // ...
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        delegate?.setCurrentChannel(currentChannel: self.channels[indexPath.row])
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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
