//
//  channelChatViewController.swift
//  chatApp
//
//  Created by Allan Pister on 09/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

class channelChatViewController: UIViewController, SBDConnectionDelegate, SBDChannelDelegate, ChattingViewDelegate, MessageDelegate {
    var channel: SBDBaseChannel!

    @IBOutlet weak var navItem: UINavigationBar!
    @IBOutlet weak var navTitle: UINavigationItem!
    @IBOutlet var chattingView: chattingView!
    
    private var refreshInViewDidAppear: Bool = true
    
    private var messageQuery: SBDPreviousMessageListQuery!
    private var delegateIdentifier: String!
    private var hasNext: Bool = true
    private var isLoading: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var title: String? = ""
        
        if let openChannel = self.channel as? SBDOpenChannel {
            title = String(format: "%@(%ld)", self.channel.name, openChannel.participantCount)
        } else {
            title = String(format: "%@", self.channel.name)
        }
        
        self.title = title
        
        SBDMain.add(self as SBDChannelDelegate, identifier: self.description)
        SBDMain.add(self as SBDConnectionDelegate, identifier: self.description)
        
        self.chattingView.sendButton.addTarget(self, action: #selector(sendMessage), for: UIControlEvents.touchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.refreshInViewDidAppear {
            self.chattingView.initChattingView()
            self.chattingView.delegate = self
            
            self.loadPreviousMessage(initial: true)
        }
        
        self.refreshInViewDidAppear = true
    }
    
    private func loadPreviousMessage(initial: Bool) {
        if initial == true {
            self.messageQuery = self.channel.createPreviousMessageListQuery()
            self.hasNext = true
            self.chattingView.messages.removeAll()
            self.chattingView.chattingTableView.reloadData()
        }
        
        if self.hasNext == false {
            return
        }
        
        if self.isLoading == true {
            return
        }
        
        self.isLoading = true
        
        self.messageQuery.loadPreviousMessages(withLimit: 30, reverse: !initial) { (messages, error) in
            if error != nil {
                let vc = UIAlertController(title: "ErrorTitle", message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                let closeAction = UIAlertAction(title: "CloseButton", style: UIAlertActionStyle.cancel, handler: nil)
                vc.addAction(closeAction)
                DispatchQueue.main.async {
                    self.present(vc, animated: true, completion: nil)
                }
                
                self.isLoading = false
                return
            }
            
            if messages?.count == 0 {
                self.hasNext = false
            }
            
            if initial == true {
                for message in messages! {
                    self.chattingView.messages.append(message)
                }
            }
            else {
                for message in messages! {
                    self.chattingView.messages.insert(message, at: 0)
                }
            }
            
            DispatchQueue.main.async {
                if initial == true {
                    self.chattingView.chattingTableView.isHidden = true
                    self.chattingView.initialLoading = true
                    self.chattingView.chattingTableView.reloadData()
                    self.chattingView.scrollToBottom()
                    
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime(uptimeNanoseconds: 250000000), execute: {
                        self.chattingView.chattingTableView.isHidden = false
                        self.chattingView.initialLoading = false
                        self.isLoading = false
                    })
                }
                else {
                    self.chattingView.chattingTableView.reloadData()
                    if (messages?.count)! > 0 {
                        self.chattingView.scrollToPosition(position: (messages?.count)! - 1)
                    }
                    self.isLoading = false
                }
            }
        }
    }
    
    @objc private func sendMessage() {
        if self.chattingView.messageTextView.text.characters.count > 0 {
            let message = self.chattingView.messageTextView.text
            self.chattingView.messageTextView.text = ""
            self.channel.sendUserMessage(message, completionHandler: { (userMessage, error) in
                if error != nil {
                    self.chattingView.resendableMessages[(userMessage?.requestId)!] = userMessage
                }
                
                self.chattingView.messages.append(userMessage!)
                DispatchQueue.main.async {
                    self.chattingView.chattingTableView.reloadData()
                    self.chattingView.scrollToBottom()
                }
            })
        }
    }
    
    // MARK: ChattingViewDelegate
    func loadMoreMessage(view: UIView) {
        self.loadPreviousMessage(initial: false)
    }
    
    func startTyping(view: UIView) {
        
    }
    
    func endTyping(view: UIView) {
        
    }
    
    func hideKeyboardWhenFastScrolling(view: UIView) {
        DispatchQueue.main.async {
            //self.bottomMargin.constant = 0
            self.view.layoutIfNeeded()
            self.chattingView.scrollToBottom()
        }
        self.view.endEditing(true)
    }
    
    // MARK: MessageDelegate
    func clickProfileImage(viewCell: UITableViewCell, user: SBDUser) {
    }
    
    func clickMessage(view: UIView, message: SBDBaseMessage) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
        let closeAction = UIAlertAction(title: "CloseButton", style: UIAlertActionStyle.cancel, handler: nil)
        var deleteMessageAction: UIAlertAction?
        var openURLsAction: [UIAlertAction] = []
        
        if message is SBDUserMessage {
            let sender = (message as! SBDUserMessage).sender
            if sender?.userId == SBDMain.getCurrentUser()?.userId {
                deleteMessageAction = UIAlertAction(title: "DeleteMessageButton", style: UIAlertActionStyle.destructive, handler: { (action) in
                    self.channel.delete(message, completionHandler: { (error) in
                        if error != nil {
                            let alert = UIAlertController(title: "ErrorTitle", message: error?.domain, preferredStyle: UIAlertControllerStyle.alert)
                            let closeAction = UIAlertAction(title: "CloseButton", style: UIAlertActionStyle.cancel, handler: nil)
                            alert.addAction(closeAction)
                            DispatchQueue.main.async {
                                self.present(alert, animated: true, completion: nil)
                            }
                        }
                    })
                })
            }
            
            do {
                let detector: NSDataDetector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
                let matches = detector.matches(in: (message as! SBDUserMessage).message!, options: [], range: NSMakeRange(0, ((message as! SBDUserMessage).message?.characters.count)!))
                for match in matches as [NSTextCheckingResult] {
                    let url: URL = match.url! as URL
                    let openURLAction = UIAlertAction(title: url.relativeString, style: UIAlertActionStyle.default, handler: { (action) in
                        self.refreshInViewDidAppear = false
                        //UIApplication.shared.openURL(url)
                    })
                    openURLsAction.append(openURLAction)
                }
            }
            catch {
                
            }
        }
        else if message is SBDAdminMessage {
            return
        }
        
        alert.addAction(closeAction)
        
        
        if deleteMessageAction != nil {
            alert.addAction(deleteMessageAction!)
        }
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
