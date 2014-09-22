//
//  TableViewCell.swift
//  MCYelp
//
//  Created by Cheng Ma on 9/21/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var mLabel: UILabel!

    @IBOutlet weak var deals: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
