//
//  EventosCreatorController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 14/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class EventosCreatorController : ViewController, DataModifiedDelegate, UITextFieldDelegate{
    @IBOutlet var imgEvento: UIImageView!
    var imgChanged:Bool = false
    var eventoAtual:EventCard?
    let imgPicker:ImagePickerManager = ImagePickerManager()
    var tbViewController:PersonsTableViewController!
    
    func getData(){
        tbViewController.persons = ModelManager.shared().connections
        tbViewController.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
        if let eventoAtual = eventoAtual{
            navigationItem.title = "Editar Evento"
            navigationItem.rightBarButtonItem?.title = "Save"
            txtName.text = eventoAtual.name
            txtEndereco.text = eventoAtual.address
            dtPicker.date = eventoAtual.date! as Date
            btnDone.isEnabled = true
            if let path = eventoAtual.photoPath{
                let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
                if let answer = answer{
                    imgEvento.image = UIImage(contentsOfFile: answer)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelManager.shared().addDelegate(newDelegate: self)
        txtName.delegate = self
        txtEndereco.delegate = self
        imgEvento.layer.cornerRadius = 20
    }
    
    func DataModified() {
        getData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tbViewController = segue.destination as? PersonsTableViewController{
            tbViewController.controller = self
            self.tbViewController = tbViewController
        }
    }
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var txtEndereco: UITextField!
    @IBOutlet var dtPicker: UIDatePicker!
    @IBOutlet var btnDone: UIBarButtonItem!
    
    var tbViewSelectedValue:[PersonCard] = []
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaveTap(_ sender: Any) {
        var newPhoto:UIImage? = nil
        if(imgChanged){
            newPhoto = imgEvento.image
        }
        
        if eventoAtual != nil{
            //            evento.feed(name: "", photoPath: "", address: "", date: nil, persons: nil)
        }
        else{
            let status:ModelStatus = ModelManager.shared().addEvent(name: txtName.text!, photo: newPhoto, address: txtEndereco.text, date: dtPicker.date as NSDate, persons:tbViewSelectedValue)
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
   
    @IBAction func imgEventoTap(_ sender: UITapGestureRecognizer) {
        imgPicker.pickImage(self) { (image) in
            self.imgEvento.image = image
            self.imgChanged = true
        }
    }
    
    private func checkDone(){
        btnDone.isEnabled = txtName.text != "" && tbViewSelectedValue.count > 0
    }
}
