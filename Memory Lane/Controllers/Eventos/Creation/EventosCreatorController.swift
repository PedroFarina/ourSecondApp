//
//  EventosCreatorController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 14/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class EventosCreatorController : UIViewController{
    @IBOutlet var imgEvento: UIImageView!
    var imgChanged:Bool = false
    var eventoAtual:EventCard?
    var tbViewController:TableViewEventFormController!
    
    
    override func viewWillAppear(_ animated: Bool) {
        if let eventoAtual = eventoAtual{
            navigationItem.title = "Editar Evento"
            navigationItem.rightBarButtonItem?.title = "Save"
            tbViewController.titulo = eventoAtual.name
            tbViewController.date = eventoAtual.date! as Date
            tbViewController.endereco = eventoAtual.address
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

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tbViewController = segue.destination as? TableViewEventFormController{
            self.tbViewController = tbViewController
            if let eventoAtual = eventoAtual{
                tbViewController.persons = eventoAtual.persons?.array as! [PersonCard]
            }
            tbViewController.btnDone = btnDone
            //self.tbViewController = tbViewController
        }
    }
    
    @IBOutlet var btnDone: UIBarButtonItem!
    
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaveTap(_ sender: Any) {
        var newPhoto:UIImage? = nil
        if(imgChanged){
            newPhoto = imgEvento.image
        }
        
        if let eventoAtual = eventoAtual{
            let status:ModelStatus = ModelManager.shared().editEvent(target: eventoAtual, newName: tbViewController.titulo, newPhoto: newPhoto, newAddress: tbViewController.endereco, newDate: tbViewController.date as NSDate, persons: tbViewController.persons)
            if(!status.successful){
                fatalError(status.description)
            }
        }
        else{
            let status:ModelStatus = ModelManager.shared().addEvent(name: tbViewController.titulo!, photo: newPhoto, address: tbViewController.endereco, date: tbViewController.date as NSDate, persons:tbViewController.persons)
            if(!status.successful){
                fatalError(status.description)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
   
    @IBAction func imgEventoTap(_ sender: UITapGestureRecognizer) {
        let imgPicker:ImagePickerManager = ImagePickerManager()
        imgPicker.pickImage(self) { (image) in
            self.imgEvento.image = image
            self.imgChanged = true
        }
    }
}
