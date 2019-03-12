//
//  ChatHelper.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 15.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class ChatHelper {

    var username: String?
    var message: String?
    var DatePost: String?
    
    init(username: String, message: String, DatePost: String) {
        self.username = username
        self.message = message
        self.DatePost = DatePost
    }
}
