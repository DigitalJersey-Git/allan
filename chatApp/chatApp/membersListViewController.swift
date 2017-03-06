//
//  membersListViewController.swift
//  chatApp
//
//  Created by Allan Pister on 02/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

class membersListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var channel: SBDOpenChannel?
    
    private var participants: [SBDUser] = []
    
    @IBOutlet weak var memberList: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let query = self.channel?.createParticipantListQuery()
        
        query?.loadNextPage(completionHandler: { (users, error) in
            if error != nil {
                return
            }
            
            for participant in users! {
                self.participants.append(participant)
            }
            
            DispatchQueue.main.async {
                self.memberList.reloadData()
            }
        })
        // Do any additional setup after loading the view.
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
        return self.participants.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memberCellID", for: indexPath)
        
        (cell as! membersCell).setCellInfo(aUser: self.participants[indexPath.row])
        
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
