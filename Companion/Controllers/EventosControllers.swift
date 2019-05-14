//
//  criarEventoController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import Foundation

public class EventoController : UITableViewController, DataModifiedDelegate{
    
    private var events:[EventCard] = ModelManager.shared().events
    
    private func getData(){
        events = ModelManager.shared().events
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
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
        return events.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as! EventTableViewCell
        //cell.lblTitle.text = events[indexPath.row].name
        //cell.lblSubtitle.text = events[indexPath.row].date?.description
        //cell.imgCard.image = UIImage(named: "teste")
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let status:ModelStatus = ModelManager.shared().removeEvent(at: indexPath.row)
            if(status.successful){
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            else{
                fatalError(status.description)
            }
            
        }
    }
    
}




class EventosCreatorController : ViewController{
    var eventoAtual:EventCard?
    
    @IBAction func btnCancelTap(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnSaveTap(_ sender: Any) {
        if eventoAtual != nil{
//            evento.feed(name: "", photoPath: "", address: "", date: nil, persons: nil)
        }
        else{
            let status:ModelStatus = ModelManager.shared().addEvent(name: "", photoPath: "", address: "", date: NSDate(), persons: [])
            if(!status.successful){
                fatalError(status.description)
            }
        }
        self.dismiss(animated: true, completion: nil)
    }
    
}
