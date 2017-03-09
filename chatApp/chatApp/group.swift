//
//  group.swift
//  chatApp
//
//  Created by Allan Pister on 01/03/2017.
//  Copyright © 2017 Mugla Kitty. All rights reserved.
//

import Foundation
import UIKit
import SendBirdSDK

struct Group {
    var image: UIImage?
    var name: String?
    var channel: Any?
    
    init(_ image: UIImage?, name: String?) {
        self.image = image
        self.name = name
    }
}
