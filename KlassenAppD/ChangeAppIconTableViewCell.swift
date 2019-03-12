//
//  ChangeAppIconTableViewCell.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 24.01.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit

class ChangeAppIconTableViewCell: UITableViewCell {

    @IBOutlet weak var ImageCe: UIImageView!
    @IBOutlet weak var NumberCell: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
