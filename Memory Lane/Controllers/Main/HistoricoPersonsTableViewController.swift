//
//  HistoricoPersonsTableViewController.swift
//  Memory Lane
//
//  Created by Rafael Galdino on 24/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class HistoricoPersonsTableViewController: UITableViewController, DataModifiedDelegate {
    private var connections:[PersonCard] = []
    private var dados:[(String, Rating)] = []
//    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let controller = segue.destination as? ConexoesViewerController{
//            controller.connectionAtual = connections[tableView.indexPathForSelectedRow!.row]
//        }
//    }
    
    private func getData(){
        connections = ModelManager.shared().connections
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        self.navigationController?.navigationBar.prefersLargeTitles = true
        tableView.delegate = self
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()
        dados = assembleList()
    }
    
    public func DataModified() {
        getData()
        dados = assembleList()
        tableView.reloadData()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var qtdRatings = 0
        for i in connections{
            if let x = i.ratings?.array.count{
                qtdRatings = x
            }
        }
        return qtdRatings
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:HistoricoPersonsTableViewCell = tableView.dequeueReusableCell(withIdentifier: "aCell") as! HistoricoPersonsTableViewCell
        cell.connectionName.text = dados[indexPath.row].0
        return cell
    }
    
        
    private func assembleList() -> [(String, Rating)]{
        var lista:[(String, Rating)] = []
        for i in connections{
            for x in i.ratings!.array{
                lista.append((i.name ?? "Noone", (x as! Rating)))
            }
        }
        lista.sort(by: { (($0.1).date! as Date).compare(($1.1).date! as Date) == ComparisonResult.orderedDescending})
        return lista
    }
    
}
