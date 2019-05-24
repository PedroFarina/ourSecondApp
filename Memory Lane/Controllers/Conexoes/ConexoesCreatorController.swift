//
//  ConexoesCreatorController.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class ConexoesCreatorController: UIViewController, UITextFieldDelegate{
    
    var connectionAtual:PersonCard?
    private var imgChanged:Bool = false
    @IBOutlet var imgConnection: UIImageView!
    var imgPicker:ImagePickerManager!
    
    @IBOutlet weak var ratingStack: RatingStack!
    @IBOutlet var txtName: UITextField!
    @IBOutlet var btnDone: UIBarButtonItem!
    
    override func viewDidLoad() {
        txtName.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    @IBAction func editionChanged(_ sender: UITextField) {
        if(sender.text?.count == 1){
            if sender.text == " "{
                sender.text = ""
                return
            }
        }
        
        guard
            let name = txtName.text, name != ""
            else{
                btnDone.isEnabled = false
                return
        }
        btnDone.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        imgConnection.layer.cornerRadius = imgConnection.frame.height/2
        ratingStack.value = 3.0
        if let con = connectionAtual{
            btnDone.isEnabled = true
            txtName.text = con.name
            ratingStack.value = Float((con.ratings?.array[0] as! Rating).value!)
            if let path = con.photoPath{
                let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
                if let answer = answer{
                    imgConnection.image = UIImage(contentsOfFile: answer)
                }
            }
        }
    }
    
    @IBAction func tapOccur(_ sender: UITapGestureRecognizer) {
        if let img = sender.view as? UIImageView{
            imgPicker = ImagePickerManager()
            imgPicker.pickImage(self) { (image) in
                self.imgConnection.image = image
                self.imgChanged = true
            }
        }
    }
    
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnDoneTap(_ sender: Any) {
        var newPhoto:UIImage? = nil
        if(imgChanged){
            newPhoto = imgConnection.image
        }
        
        if let connection = connectionAtual{
            let status:ModelStatus = ModelManager.shared().editInitialConnection(target: connection, newName: txtName.text, newPhoto: newPhoto, newRating: Decimal(Double(ratingStack.value)))
            if(!status.successful){
                fatalError(status.description)
            }
        }
        else{
            let status:ModelStatus = ModelManager.shared().addConnection(name: txtName.text!, photo: newPhoto, ratingInicial: Decimal(Double(ratingStack.value)))
            if(!status.successful){
                fatalError(status.description)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
