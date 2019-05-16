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
        if let _ = imgIcon{
            imgIcon.layer.cornerRadius = imgIcon.frame.height/2
            imgIcon.layer.borderWidth = 1
            imgIcon.layer.borderColor = #colorLiteral(red: 0.9168350101, green: 0.279589951, blue: 0.4638584256, alpha: 1)
        }
    }
}
