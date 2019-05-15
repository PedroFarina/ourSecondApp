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
    var eventAtual:EventCard!
    
    override func viewDidLoad() {
        navigationItem.title = eventAtual.name
    }
}
