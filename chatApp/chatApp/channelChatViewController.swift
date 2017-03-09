//
//  channelChatViewController.swift
//  chatApp
//
//  Created by Allan Pister on 09/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

class channelChatViewController: UIViewController, SBDConnectionDelegate, SBDChannelDelegate {
    var channel: SBDOpenChannel!

    @IBOutlet weak var chatList: UITableView!
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let titleView: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 100, height: 64))
        
        var mainTitleAttribute: [String:AnyObject]?
        
        mainTitleAttribute = [ NSForegroundColorAttributeName: UIColor.black ]
        var fullTitle: NSMutableAttributedString?
        let title = String(format: "%@(%ld)", self.channel.name, self.channel.participantCount)
        fullTitle = NSMutableAttributedString(string: title)
        fullTitle?.addAttributes(mainTitleAttribute!, range: NSMakeRange(0, title.characters.count))
        
        titleView.attributedText = fullTitle
        titleView.numberOfLines = 2
        titleView.textAlignment = NSTextAlignment.center
        // Do any additional setup after loading the view.
        
        //self.navItem.titleView = titleView
        
        SBDMain.add(self as SBDChannelDelegate, identifier: self.description)
        SBDMain.add(self as SBDConnectionDelegate, identifier: self.description)
        
        //self.chattingView.sendButton.addTarget(self, action: #selector(sendMessage), for: UIControlEvents.touchUpInside)
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
