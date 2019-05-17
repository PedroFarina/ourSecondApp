//
//  tableViewDatePickerController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit


class TableViewEventFormController:UITableViewController, PersonSelectedDelegate{
    var btnDone:UIBarButtonItem?
    var dataAtual:Date?
    var df:DateFormatter = DateFormatter()
    
    private var dpShowDateVisible = false
    
    var date:Date{
        get{
            return datePickerCell.dtPicker.date
        }
        set{
            datePickerCell.dtPicker.date = newValue
        }
    }
    var titulo:String?{
        get{
            return tituloCell.txtTitulo.text
        }
        set{
            tituloCell.txtTitulo.text = newValue
        }
    }
    var endereco:String?{
        get{
            return localeCell.txtTitulo.text
        }
        set{
            localeCell.txtTitulo.text = newValue
        }
    }
    public var persons:[PersonCard] = []
    private var tituloCell:TextCell!
    private var localeCell:TextCell!
    private var datePickerCell:DatePickerCell!
    private var tbViewPersons:PersonsTableViewController!
    
    func personsSelectedChanged(selected:Bool, person:PersonCard) {
        if(selected){
            persons.append(person)
        }
        else{
            persons.remove(at: persons.firstIndex(of: person)!)
        }
        checkDone()
    }
    
    public override func viewDidLoad() {
        df.dateFormat = "dd MMMM yyyy       hh:mm"
        super.viewDidLoad()
        if dataAtual == nil{
            dataAtual = Date()
        }
        tituloCell = (tableView.dequeueReusableCell(withIdentifier: "tituloCell") as! TextCell)
        
        tituloCell.txtTitulo.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        
        datePickerCell = (tableView.dequeueReusableCell(withIdentifier: "datePickerCell") as! DatePickerCell)
        datePickerCell.dtPicker.date = dataAtual!
        localeCell = (tableView.dequeueReusableCell(withIdentifier: "tituloCell") as! TextCell)
        localeCell.txtTitulo.placeholder = "Endereço"
        localeCell.txtTitulo.textContentType = .fullStreetAddress
        
        tableView.tableFooterView = UIView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc func editingChanged(){
        if tituloCell.txtTitulo.text == " "{
            tituloCell.txtTitulo.text = ""
        }
        checkDone()
    }
    
    func checkDone(){
        btnDone?.isEnabled = tituloCell.txtTitulo.text != "" && persons.count > 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? PersonsTableViewController{
            tbViewPersons = dest
            dest.selectedPersons = persons
            dest.delegate = self
            dest.persons = ModelManager.shared().connections
        }
    }
    
    private func toggleShowDateDatepicker () {
        dpShowDateVisible = !dpShowDateVisible
        
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Secion \(section)"
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = UIView()
        vw.backgroundColor = .white
        
        return vw
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0{
            return 2 + min(persons.count, 4)
        }
        else{
            return 3
        }
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell = UITableViewCell()
        if indexPath.section == 0{
            if indexPath.row == 0{
                cell  = tituloCell
            }
            else if indexPath.row == 1{
                cell = tableView.dequeueReusableCell(withIdentifier: "personsCell")!
            }
            else if indexPath.row == 5{
                cell = UITableViewCell()
                cell.textLabel?.text = "..."
            }
            else{
                cell = UITableViewCell()
                cell.textLabel?.text = persons[(indexPath.row - 2)].name
            }
        }
        else if indexPath.section == 1{
            if indexPath.row == 0{
                cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                cell.textLabel?.text = "Date"
                cell.detailTextLabel?.text = df.string(from: date)
            }
            else if indexPath.row == 1{
                cell = datePickerCell
            }
            else if indexPath.row == 2{
                cell = localeCell
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if !dpShowDateVisible && indexPath == IndexPath(row: 1, section: 1){
            return 0
        }
        else if dpShowDateVisible && indexPath == IndexPath(row: 1, section: 1){
            return 182
        }
        else {
            return 44
        }
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath == IndexPath(row: 0, section: 1) {
            toggleShowDateDatepicker()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override public func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}


class TextCell : UITableViewCell, UITextFieldDelegate{
    override func awakeFromNib() {
        super.awakeFromNib()
        txtTitulo.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBOutlet var txtTitulo: UITextField!
}

class DatePickerCell : UITableViewCell{
    @IBOutlet var dtPicker: UIDatePicker!
    
    @IBAction func dateChanged(_ sender: Any) {
        (self.superview as! UITableView).reloadData()
    }
}
