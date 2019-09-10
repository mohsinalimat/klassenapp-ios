//
//  AppImageTableViewCell.swift
//  KlassenAppD
//
//  Created by Adrian Baumgart on 19.07.19.
//  Copyright © 2019 Adrian Baumgart. All rights reserved.
//

import UIKit

class AppImageTableViewCell: UITableViewCell {
    var imageV: UIImageView!
    var countLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()

        imageV.frame = CGRect(x: 10, y: 10, width: 60, height: 60)
        contentView.addSubview(imageV)

        countLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 10)
        countLabel.isHidden = true
        contentView.addSubview(countLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
