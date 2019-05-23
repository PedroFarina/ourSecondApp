//
//  EventosController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 14/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit


class EventosController:UIViewController, DataModifiedDelegate{
    private var events:[EventCard] = ModelManager.shared().events
    private var eventNext:[EventCard] = []
    private var eventPrevious:[EventCard] = []
    private var tableViewController:EventosTableViewController!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let tableViewController = segue.destination as? EventosTableViewController{
            self.tableViewController = tableViewController
            tableViewController.controller = self
        }
        else if let viewerViewController = segue.destination as? EventosViewerController{
            viewerViewController.eventoAtual = sender as? EventCard
        }
    }
    
    private func getData(){
        events = ModelManager.shared().events
        eventNext = []
        eventPrevious = []
        let today:Date = Date()
        for event in events{
            if let eventDate = event.date{
                if (eventDate as Date) < today{
                    eventPrevious.append(event)
                }
                else{
                    eventNext.append(event)
                }
            }
        }
        
        if segmentedControl.selectedSegmentIndex == 0{
            tableViewController.events = eventNext
        }
        else{
            tableViewController.events = eventPrevious
        }
        
        tableViewController.tableView.reloadData()
    }
    
    func DataModified() {
        getData()
    }
    
    override func viewDidLoad() {
        navigationItem.leftBarButtonItem = tableViewController.editButtonItem
        self.navigationController?.navigationBar.prefersLargeTitles = true
        ModelManager.shared().addDelegate(newDelegate:self)
        getData()
    }
    
    @IBOutlet var segmentedControl: UISegmentedControl!
    @IBOutlet var btnAdd: UIBarButtonItem!
    
    @IBAction func segmentedValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            navigationItem.rightBarButtonItem = btnAdd
            tableViewController.events = eventNext
        case 1:
            navigationItem.rightBarButtonItem = nil
            tableViewController.events = eventPrevious
        default:
            break
        }
        tableViewController.isEditing = false
        tableViewController.tableView.reloadData()
    }
    
}
