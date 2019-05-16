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
        if let _ = events[indexPath.row].photoPath{
            return 150
        }
        return 65
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event:EventCard = events[indexPath.row]
        var cell:UITableViewCell!
        if let path = event.photoPath{
            let eventCell = tableView.dequeueReusableCell(withIdentifier: "eventCell") as? EventTableViewCell
            eventCell?.lblName.text = event.name
            eventCell?.lblDate.text = df.string(from: event.date! as Date)
            let answer: String? = FileHelper.getFile(filePathWithoutExtension: path)
            if let answer = answer{
                eventCell?.imgIcon.image = UIImage(contentsOfFile: answer)
                //eventCell?.imgIcon.image = UIImage(cgImage: eventCell?.imgIcon as! CGImage, scale: 1, orientation: UIImage.Orientation.up)
            }
            cell = eventCell
        }
        else{
            cell = tableView.dequeueReusableCell(withIdentifier: "noPhotoCell")
            cell.textLabel?.text = event.name
            cell.detailTextLabel?.text = df.string(from: event.date! as Date)
        }
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
