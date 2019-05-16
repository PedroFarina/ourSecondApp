//
//  PersonsViewController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

protocol PersonSelectedDelegate{
    func personsSelectedChanged(selected:Bool, person:PersonCard)
}

class PersonsTableViewController:UITableViewController{
    var selectedValues:[PersonCard]{
        get{
            var copy:[PersonCard] = []
            for value in selectedValue{
                copy.append(value.value)
            }
            return copy
        }
    }
    private var selectedValue:[Int:PersonCard] = [:]
    var persons:[PersonCard] = []
    var selectedPersons:[PersonCard]?
    public var delegate:PersonSelectedDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let selectedPersons = selectedPersons{
            for personSelected in selectedPersons{
                if let index = persons.firstIndex(of: personSelected){
                    let indexPath = IndexPath(row: index, section: 0)
                    tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
                    tableView.cellForRow(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.8470588235, blue: 0.3294117647, alpha: 1)
                }
            }
        }
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
        tableView.cellForRow(at: indexPath)?.backgroundColor = #colorLiteral(red: 0.4666666667, green: 0.8470588235, blue: 0.3294117647, alpha: 1)
        delegate?.personsSelectedChanged(selected: true, person: persons[indexPath.row])
    }
    
    override public func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedValue[indexPath.row] = nil
        tableView.cellForRow(at: indexPath)?.backgroundColor = .white
        delegate?.personsSelectedChanged(selected: false, person: persons[indexPath.row])
    }
    
}
