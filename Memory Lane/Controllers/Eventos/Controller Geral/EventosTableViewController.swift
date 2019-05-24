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
    private var df:DateFormatter = DateFormatter()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        df.dateFormat = "dd/MMMM"
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    public override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event:EventCard = events[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as! EventTableViewCell
        cell.lblName.text = event.name
        cell.lblDate.text = df.string(from: event.date! as Date)
        cell.ratingStack.value = Float(event.rating?.value! ?? 0)
        if let path = event.photoPath{
            let answer: String? = FileHelper.getFile(filePathWithoutExtension: path)
            if let answer = answer{
                cell.imgIcon.image = UIImage(contentsOfFile: answer)
            }
        }
        return cell
    }
    
    override public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let status:ModelStatus = ModelManager.shared().removeEvent(at: indexPath.row)
            if(!status.successful){
                fatalError(status.description)
            }
        }
    }
    
    public override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        controller.performSegue(withIdentifier: "selectEvent", sender: events[indexPath.row])
    }
    
}
