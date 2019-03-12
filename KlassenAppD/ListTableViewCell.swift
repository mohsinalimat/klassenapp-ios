//
//  ListTableViewCell.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 11.11.18.
//  Copyright © 2018 Adrian Baumgart. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var CellName: UILabel!
    @IBOutlet weak var CellTS: UILabel!
    @IBOutlet weak var CellMessage: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
