//
//  ConexoesController.swift
//  Companion
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
