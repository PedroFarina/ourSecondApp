//
//  RatingTableViewController.swift
//  Memory Lane
//
//  Created by Pedro Henrique Guedes Silveira on 24/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class RatingTableViewController: UITableViewController {
    
    var connection:PersonCard?
    {
        didSet{
            ratings = connection?.ratings?.array as! [Rating]
            tableView.reloadData()
        }
    }
    private var ratings:[Rating] = []
    private var df:DateFormatter = DateFormatter()

    override func viewWillAppear(_ animated: Bool) {
        ratings = connection?.ratings?.array as! [Rating]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        df.dateFormat = "dd/MMMM"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rating:Rating = ratings[indexPath.row]
        let cell:RatingTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ratingCell") as! RatingTableViewCell
        
        cell.lblDate.text = df.string(from: rating.date! as Date)
        cell.ratingValue.value = Float(Int(truncating: rating.value!))
        
        
        return cell
        }
    
    }
    
    
    
    



