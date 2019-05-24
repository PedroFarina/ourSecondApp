//
//  TableViewCell.swift
//  Memory Lane
//
//  Created by Pedro Henrique Guedes Silveira on 24/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var ratingCell: UIView!
    
    @IBOutlet weak var ratingValue: RatingStack!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if let _ = lblDate {
            
            ratingCell.layer.borderColor = UIColor.black.cgColor
            ratingCell.layer.cornerRadius = ratingCell.frame.height/2
            ratingCell.layer.shadowOpacity = 6
            ratingCell.layer.shadowRadius = 2
            ratingCell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1087698063)
            ratingCell.layer.shadowOffset = CGSize(width: 3, height: 3)

            
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
