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
    @IBOutlet weak var eventCell: UIView!
    @IBOutlet weak var ratingStack: RatingStack!
    
    override func awakeFromNib() {
        
        eventCell.layer.borderColor = UIColor.black.cgColor
        eventCell.layer.cornerRadius = eventCell.frame.height/8
        eventCell.layer.shadowOpacity = 6
        eventCell.layer.shadowRadius = 2
        eventCell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1087698063)
        eventCell.layer.shadowOffset = CGSize(width: 3, height: 3)

        if let _ = imgIcon{
            imgIcon.layer.cornerRadius = imgIcon.frame.height/8

        }
    }
}
