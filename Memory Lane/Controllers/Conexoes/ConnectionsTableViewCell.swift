//
//  ConnectionsTableViewCell.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 16/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation

import UIKit

class ConnectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var connectionName: UILabel!
    @IBOutlet weak var connectionImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if let _ = connectionImage {
            connectionImage.layer.cornerRadius = connectionImage.frame.height/2
        }
//        containerView.layer.cornerRadius = containerView.frame.height/2
//        containerView.layer.borderWidth = 1
//        containerView.layer.borderColor = #colorLiteral(red: 0.1490196139, green: 0.1490196139, blue: 0.1490196139, alpha: 1)
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
