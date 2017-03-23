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
    
    @IBOutlet weak var memberList: UITableView!
    
    private var users: [SBDUser] = []
    private var userListQuery: SBDUserListQuery?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.memberList.delegate = self
        self.memberList.dataSource = self
        
        self.loadUserList(initial: true)
        // Do any additional setup after loading the view.
    }
    
    private func loadUserList(initial: Bool) {
        if initial == true {
            self.users.removeAll()
            
            DispatchQueue.main.async {
                self.memberList.reloadData()
            }
            
            self.userListQuery = nil;
        }
        
        if self.userListQuery == nil {
            self.userListQuery = SBDMain.createAllUserListQuery()
            self.userListQuery?.limit = 25
        }
        
        self.userListQuery?.loadNextPage(completionHandler: { (users, error) in
            if error != nil {
                let vc = UIAlertController(title: "Error", message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler:nil)
                vc.addAction(closeAction)
                DispatchQueue.main.async {
                    self.present(vc, animated: true, completion: nil)
                }
                return
            }
            
            for user in users! as [SBDUser] {
                if user.userId == SBDMain.getCurrentUser()?.userId {
                    continue
                }
                self.users.append(user)
            }
            
            DispatchQueue.main.async {
                self.memberList.reloadData()
            }
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // This will be the number of rows returned in the query.
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "membersCell", for: indexPath)
        
        (cell as! membersCell).setCellInfo(aUser: self.users[indexPath.row])
        
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
