//
//  EventosTableViewController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 14/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit


public class EventosTableViewController : UITableViewController{
    var controller:EventosController!
    public var events:[EventCard] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "aCell") as! EventTableViewCell
        cell.textLabel!.text = events[indexPath.row].name
        //cell.lblName.text = events[indexPath.row].name
        //cell.lblDate.text = events[indexPath.row].date?.description
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
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.performSegue(withIdentifier: "selectEvent", sender: events[indexPath.row])
    }
    
}
