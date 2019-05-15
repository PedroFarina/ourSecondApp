//
//  EventosCreatorController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 14/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class EventosCreatorController : ViewController{
    var eventoAtual:EventCard?
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tbViewController = segue.destination as? PersonsTableViewController{
            tbViewController.controller = self
        }
    }
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEndereco: UITextField!
    @IBOutlet var dtPicker: UIDatePicker!
    @IBOutlet var btnDone: UIBarButtonItem!
    
    var tbViewSelectedValue:[PersonCard] = []
    
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaveTap(_ sender: Any) {
        if eventoAtual != nil{
            //            evento.feed(name: "", photoPath: "", address: "", date: nil, persons: nil)
        }
        else{
            let status:ModelStatus = ModelManager.shared().addEvent(name: txtName.text!, photoPath: "", address: txtEndereco.text, date: dtPicker.date as NSDate, persons:tbViewSelectedValue)
            if(!status.successful){
                fatalError(status.description)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func editionChanged(_ sender: UITextField) {
        if(sender.text?.count == 1){
            if sender.text == " "{
                sender.text = ""
                return
            }
        }
        checkDone()
    }
    
    public func tableViewSelect(selected:[Int:PersonCard]){
        tbViewSelectedValue = []
        for person in selected{
            tbViewSelectedValue.append(person.value)
        }
        checkDone()
    }
    
    private func checkDone(){
        btnDone.isEnabled = txtName.text != "" && tbViewSelectedValue.count > 0
    }
}


class PersonsTableViewController:UITableViewController{
    public var selectedValue:[Int:PersonCard] = [:]
    private var persons:[PersonCard] = ModelManager.shared().connections
    public var controller:EventosCreatorController!
    
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedValue[indexPath.row] = persons[indexPath.row]
        controller.tableViewSelect(selected: selectedValue)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        selectedValue[indexPath.row] = nil
        controller.tableViewSelect(selected: selectedValue)
    }
    
}
