//
//  criarConexaoController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import Foundation

public class ConexoesController : UITableViewController, DataModifiedDelegate{
    private var connections:[PersonCard] = []
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ConexoesViewerController{
            controller.connectionAtual = connections[tableView.indexPathForSelectedRow!.row]
        }
    }
    
    private func getData(){
        connections = ModelManager.shared().connections
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.leftBarButtonItem = self.editButtonItem
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()
    }
    
    public func DataModified() {
        getData()
        tableView.reloadData()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectionCell") as! ConnectionTableViewCell
        cell.textLabel?.text = connections[indexPath.row].name
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let status:ModelStatus = ModelManager.shared().removeConnection(at: indexPath.row)
            if(!status.successful){
                fatalError(status.description)
            }
        }
    }
}

class ConexoesViewerController : ViewController{
    var connectionAtual:PersonCard?
    
    override func viewWillAppear(_ animated: Bool){
        super.viewDidLoad()
        if connectionAtual != nil{
            navigationItem.title = connectionAtual!.name
        }
        else{
            navigationItem.title = "Error"
        }
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController{
            if let controller = navController.topViewController as? ConexoesCreatorController{
                controller.connectionAtual = connectionAtual
                 controller.navigationItem.title = "Editar Conexão"
                controller.navigationItem.rightBarButtonItem?.title = "Save"
            }
        }
    }
}


class ConexoesCreatorController: ViewController{
    var connectionAtual:PersonCard?
    private var imgChanged:Bool = false
    private var rating:Int = 3
    @IBOutlet var imgConnection: UIImageView!
    @IBOutlet weak var lastImage: UIImageView!
    @IBOutlet var imagesView: [UIImageView]!
    let imgPicker:ImagePickerManager = ImagePickerManager()
    
    @IBOutlet var txtName: UITextField!
    @IBOutlet var btnDone: UIBarButtonItem!
    
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
    
    @IBOutlet var txtNome: UITextField!
    @IBAction func tapOccur(_ sender: UITapGestureRecognizer) {
        if let img = sender.view as? UIImageView{
            switch img.tag{
            case 0:
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
