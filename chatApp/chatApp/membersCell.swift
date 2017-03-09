//
//  membersCell.swift
//  chatApp
//
//  Created by Allan Pister on 02/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import UIKit
import SendBirdSDK
import AlamofireImage

class membersCell: UITableViewCell {

    @IBOutlet weak var memberImage: UIImageView!
    @IBOutlet weak var memberName: UILabel!
    @IBOutlet weak var lastOnlineDT: UILabel!
    
    private var user: SBDUser!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setCellInfo(aUser:SBDUser) {
        self.user = aUser
        
        self.memberImage.af_setImage(withURL: URL(string: self.user.profileUrl!)!, placeholderImage:UIImage(named: "img_profile"))
        self.memberName.text = self.user.nickname
        
        if self.user.connectionStatus == SBDUserConnectionStatus.online {
            self.lastOnlineDT.text = "Online"
            self.lastOnlineDT.textColor = UIColor(red: 41.0/255.0, green: 197.0/255.0, blue: 25.0/255.0, alpha: 1)
        } else {
            let lastMessageDateFormatter = DateFormatter()
            var lastMessageDate: Date?
            
            // If lastSeenAt value is larger then 10 digits then convert lastSeenAt value so that milliseconds are fraction part.
            if String(format: "%lld", self.user.lastSeenAt).characters.count == 10 {
                lastMessageDate = Date(timeIntervalSince1970: Double(self.user.lastSeenAt))
            } else {
                lastMessageDate = Date(timeIntervalSince1970: Double(self.user.lastSeenAt) / 1000.0)
            }
            let currDate = Date()
            
            let lastMessageDateComponents = NSCalendar.current.dateComponents([.day, .month, .year], from: lastMessageDate! as Date)
            let currDateComponents = NSCalendar.current.dateComponents([.day, .month, .year], from: currDate as Date)
            
            if lastMessageDateComponents.year != currDateComponents.year || lastMessageDateComponents.month != currDateComponents.month || lastMessageDateComponents.day != currDateComponents.day {
                lastMessageDateFormatter.dateStyle = DateFormatter.Style.short
                lastMessageDateFormatter.timeStyle = DateFormatter.Style.none
                self.lastOnlineDT.text = lastMessageDateFormatter.string(from: lastMessageDate!)
            } else {
                lastMessageDateFormatter.dateStyle = DateFormatter.Style.none
                lastMessageDateFormatter.timeStyle = DateFormatter.Style.medium
                self.lastOnlineDT.text = lastMessageDateFormatter.string(from: lastMessageDate!)
            }
            
            self.lastOnlineDT.textColor = UIColor(red: 142.0/255.0, green: 142.0/255.0, blue: 142.0/255.0, alpha: 1)
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
