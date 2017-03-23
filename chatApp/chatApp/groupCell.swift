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

    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var groupImage: UIImageView!
    @IBOutlet weak var groupParicapantCnt: UILabel!
    
    private var channel: SBDBaseChannel!
    
    var group: Group! {
        didSet {
            groupName.text = group.name
            //groupImage.image = imageForGroup()
        }
    }
    
    func imageForGroup() -> UIImage? {
        return UIImage(named: "chatimg")
    }
    
    func setCellInfo(aChannel: SBDBaseChannel) {
        self.channel = aChannel
        
        self.groupName.text = self.channel.name
        
        if let openChannl = self.channel as? SBDOpenChannel {
            self.groupParicapantCnt.text = String(openChannl.participantCount) + " Participant" + String((openChannl.participantCount <= 1) ? "" : "s")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
