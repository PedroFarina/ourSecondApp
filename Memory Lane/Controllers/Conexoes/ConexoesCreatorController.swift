//
//  ConexoesCreatorController.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class ConexoesCreatorController: ViewController, UITextFieldDelegate{
    var connectionAtual:PersonCard?
    private var imgChanged:Bool = false
    private var rating:Int = 3
    @IBOutlet var imgConnection: UIImageView!
    @IBOutlet weak var lastImage: UIImageView!
    @IBOutlet var imagesView: [UIImageView]!
    var imgPicker:ImagePickerManager!
    
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
        if let con = connectionAtual{
            btnDone.isEnabled = true
            txtName.text = con.name
            lastImage = imagesView![Int(truncating: (con.ratings?.array[0] as! Rating).value!) - 1]
            if let path = con.photoPath{
                let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
                if let answer = answer{
                    imgConnection.image = UIImage(contentsOfFile: answer)
                }
            }
        }
        lastImage.isHighlighted = true
    }
    
    @IBAction func tapOccur(_ sender: UITapGestureRecognizer) {
        if let img = sender.view as? UIImageView{
            switch img.tag{
            case 0:
                imgPicker = ImagePickerManager()
                imgPicker.pickImage(self) { (image) in
                    self.imgConnection.image = image
                    self.imgChanged = true
                }
            default:
                lastImage.isHighlighted = false
                rating = img.tag
                img.isHighlighted = true
                lastImage = img
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
            let status:ModelStatus = ModelManager.shared().editInitialConnection(target: connection, newName: txtName.text, newPhoto: newPhoto, newRating: Decimal(rating))
            if(!status.successful){
                fatalError(status.description)
            }
        }
        else{
            let status:ModelStatus = ModelManager.shared().addConnection(name: txtName.text!, photo: newPhoto, ratingInicial: Decimal(rating))
            if(!status.successful){
                fatalError(status.description)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}

