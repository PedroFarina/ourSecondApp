//
//  PersonsViewController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class PersonsTableViewController:UITableViewController{
    public var selectedValue:[Int:PersonCard] = [:]
    var persons:[PersonCard] = []
    public var controller:EventosCreatorController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as! ConnectionTableViewCell
        cell.textLabel?.text = persons[indexPath.row].name
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
    
    override public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedValue[indexPath.row] = persons[indexPath.row]
        controller?.tableViewSelect(selected: selectedValue)
    }
    
    override public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedValue[indexPath.row] = nil
        controller?.tableViewSelect(selected: selectedValue)
    }
    
}
