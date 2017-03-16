//
//  MessageDelegate.swift
//  chatApp
//
//  Created by Allan Pister on 09/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import Foundation
import UIKit
import SendBirdSDK

protocol MessageDelegate: class {
    func clickProfileImage(viewCell: UITableViewCell, user: SBDUser)
    func clickMessage(view: UIView, message: SBDBaseMessage)
}
