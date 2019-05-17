//
//  ConexoesController.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 15/05/19.
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
        tableView.tableFooterView = UIView()
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
        var cell:UITableViewCell!
        let connectionAtual = connections[indexPath.row]
        
        //        cell.textLabel?.text = connections[indexPath.row].name
        
        if let path = connectionAtual.photoPath{
            let conCell = tableView.dequeueReusableCell(withIdentifier: "connectionCell") as! ConnectionTableViewCell
            conCell.connectionName.text = connectionAtual.name
            let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
            if let answer = answer{
                conCell.connectionImage.image = UIImage(contentsOfFile: answer)
            }
            let personImage = conCell.connectionImage
            
            
            switch connectionAtual.rating(){
            case 0...1:
                personImage?.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.631372549, blue: 0.8352941176, alpha: 1)
            case 1..<1.5:
                personImage?.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.631372549, blue: 0.8352941176, alpha: 1)
            case 1.5..<2.5:
                personImage?.layer.borderColor =  #colorLiteral(red: 0.1098039216, green: 0.5019607843, blue: 0.7490196078, alpha: 1)
            case 2.5..<3.5:
                personImage?.layer.borderColor = #colorLiteral(red: 0.4509803922, green: 0.3254901961, blue: 0.6352941176, alpha: 1)
            case 3.5..<4.5:
                personImage?.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.168627451, blue: 0.2862745098, alpha: 1)
            case 4.5...5:
                personImage?.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.1882352941, blue: 0.3843137255, alpha: 1)
                
            default:
                personImage?.layer.borderWidth = 0
                
            }
            
            cell = conCell
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "connectionCellNoPhoto")
            cell.textLabel?.text = connectionAtual.name
        }
        //        cell.imageView? = connections[indexPath.row].photoPath
        return cell
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let _ = connections[indexPath.row].photoPath {
            return 150
        }
        return 65
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
