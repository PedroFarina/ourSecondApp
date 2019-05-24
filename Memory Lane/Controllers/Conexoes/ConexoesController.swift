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
    private var viewerController:ConexoesViewerController?
    private var connections:[PersonCard] = []
    private var indice:Int!
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ConexoesViewerController{
            viewerController = controller
            indice = tableView.indexPathForSelectedRow!.row
            
            controller.connectionAtual = connections[indice]
        }
    }
    
    private func getData(){
        connections = ModelManager.shared().connections
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        navigationItem.leftBarButtonItem = self.editButtonItem
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()
    }
    
    public func DataModified() {
        getData()
        tableView.reloadData()
        viewerController?.connectionAtual = connections[indice]
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:ConnectionTableViewCell = tableView.dequeueReusableCell(withIdentifier: "connectionCell") as! ConnectionTableViewCell
        let connectionAtual = connections[indexPath.row]
        cell.connectionName.text = connectionAtual.name
        if let path = connectionAtual.photoPath{
            let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
            if let answer = answer{
                cell.connectionImage.image = UIImage(contentsOfFile: answer)
            }
        }
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
