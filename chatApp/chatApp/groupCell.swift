//
//  groupCellTableViewCell.swift
//  chatApp
//
//  Created by Allan Pister on 27/02/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK

class groupCell: UITableViewCell {

    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupParicapantCnt: UILabel!
    @IBOutlet weak var groupName: UILabel!
    
    private var channel: SBDOpenChannel!

    func imageForGroup() -> UIImage? {
        return UIImage(named: "chatimg")
    }
    
    func setCellInfo(aChannel: SBDOpenChannel) {
        self.channel = aChannel
        
        self.groupName.text = self.channel.name
        self.groupParicapantCnt.text = String(self.channel.participantCount) + " Participant" + String((self.channel.participantCount <= 1) ? "" : "s")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
