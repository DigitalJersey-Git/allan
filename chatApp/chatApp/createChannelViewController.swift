//
//  createChannelViewController.swift
//  chatApp
//
//  Created by Allan Pister on 23/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

protocol CreateGroupChannelSelectOptionViewControllerDelegate: class {
    func didFinishCreating(channel: SBDGroupChannel, vc: UIViewController)
}

class createChannelViewController: UIViewController {
    weak var delegate: CreateGroupChannelSelectOptionViewControllerDelegate?
    @IBOutlet weak var groupName: UITextField!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var cancel: UIButton!
    
    var selectedUser: [SBDUser] = []
    
    @IBAction func cancelCreate(segue:UIStoryboardSegue) {
    }
    
    @IBAction func createPush(_ sender: Any) {
        // Here we need to create the closed group and drop the user into the
        // chat view so they can start chating.
        self.activityIndicator.isHidden = false
        self.activityIndicator.startAnimating()
        
        self.createChannel()
    }

    private func createChannel() {
        if self.groupName.text == nil { return }
        
        SBDGroupChannel.createChannel(withName: self.groupName.text, users: self.selectedUser, coverUrl: nil, data: nil, completionHandler: { (channel, error) in
            if error != nil {
                let vc = UIAlertController(title: "Error", message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                let closeAction = UIAlertAction(title: "CloseButton", style: UIAlertActionStyle.cancel, handler: { (action) in
                    
                })
                vc.addAction(closeAction)
                DispatchQueue.main.async {
                    self.present(vc, animated: true, completion: nil)
                }
                
                self.activityIndicator.stopAnimating()
                
                return
            }
            
            let vc = UIAlertController(title: "GroupChannel \(self.groupName.text) Created", message: "You have just created a new group now you will need to add new members to it.", preferredStyle: UIAlertControllerStyle.alert)
            let closeAction = UIAlertAction(title: "Close", style: UIAlertActionStyle.cancel, handler: { (action) in
                self.dismiss(animated: false, completion: {
                    if self.delegate != nil {
                        self.delegate?.didFinishCreating(channel: channel!, vc: self)
                    }
                })
            })
            vc.addAction(closeAction)
            self.present(vc, animated: true, completion: {
                
            })
            
            self.activityIndicator.stopAnimating()
        })
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.activityIndicator.isHidden = true
        self.activityIndicator.hidesWhenStopped = true
        self.activityIndicator.stopAnimating()

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
