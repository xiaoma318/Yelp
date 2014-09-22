//
//  ResturantCell.swift
//  MCYelp
//
//  Created by Cheng Ma on 9/21/14.
//  Copyright (c) 2014 Charlie. All rights reserved.
//

import UIKit

class ResturantCell: UITableViewCell {


    @IBOutlet weak var profile: UIImageView!
    @IBOutlet weak var name: UILabel!
  
    @IBOutlet weak var review: UIImageView!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var reviewCount: UILabel!

    @IBOutlet weak var kind: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
