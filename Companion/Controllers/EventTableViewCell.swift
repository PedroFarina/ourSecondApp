//
//  EventTableViewCell.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 11/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet var imgIcon: UIImageView!
    @IBOutlet var lblName: UILabel!
    @IBOutlet var lblDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
