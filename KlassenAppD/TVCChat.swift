//
//  TVCChat.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 15.09.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class TVCChat: UITableViewCell {
    @IBOutlet weak var usernameCel: UILabel!
    @IBOutlet weak var messageCell: UITextView!
    
    
    func setChat(chat:ChatHelper) {
        usernameCel.text = chat.username
        messageCell.text = chat.message
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
