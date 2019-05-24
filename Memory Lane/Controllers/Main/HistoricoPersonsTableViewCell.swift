//
//  HistoricoPersonsTableViewCell.swift
//  Memory Lane
//
//  Created by Rafael Galdino on 24/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
class HistoricoPersonsTableViewCell: UITableViewCell {

    @IBOutlet weak var personCell: UIView!
    @IBOutlet weak var connectionName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        personCell.layer.borderColor = UIColor.black.cgColor
        personCell.layer.cornerRadius = personCell.frame.height/2
        personCell.layer.shadowOpacity = 6
        personCell.layer.shadowRadius = 2
        personCell.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1087698063)
        personCell.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
}
