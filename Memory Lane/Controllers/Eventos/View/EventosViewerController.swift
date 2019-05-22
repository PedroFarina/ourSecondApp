//
//  EventosViewerController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class EventosViewerController:UIViewController{
    var eventoAtual:EventCard!
    var tbViewController:PersonsTableViewController!
    let df:DateFormatter = DateFormatter()
    
    @IBOutlet var imgEvento: UIImageView!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblNome: UILabel!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? PersonsTableViewController{
            tbViewController = controller
            controller.tableView.allowsSelection = false
            controller.persons = eventoAtual.persons?.array as! [PersonCard]
            controller.tableView.separatorStyle = .none
        }
        else if let navController = segue.destination as? UINavigationController{
            if let controller = navController.topViewController as? EventosCreatorController{
                controller.eventoAtual = eventoAtual
            }
            else if let popup = navController.topViewController as? RatingController{
                popup.evento = eventoAtual
            }
        }
    }
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool){
        df.dateFormat = "dd-MM-yy hh:mm"
        navigationItem.title = eventoAtual.name
        lblDate.text = df.string(from: eventoAtual.date! as Date)
        lblNome.text = eventoAtual.name
        if let path = eventoAtual.photoPath{
            let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
            if let answer = answer{
                imgEvento.image = UIImage(contentsOfFile: answer)
            }
        }
    }
    
}
