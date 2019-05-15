//
//  EventCard+CoreDataClass.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit

public class EventCard: Card {
    private let df = DateFormatter()
    
    func feed(name:String, photo:UIImage?, address:String?, date:NSDate, persons:[PersonCard]){
        df.dateFormat = "dd-MM-yyyy hh:mm:ssZ"
        
        self.name = name
        if let photo = photo{
            let photoPath = df.string(from: Date())
            FileHelper.saveImage(image: photo, nameWithoutExtension: photoPath)
            self.photoPath = photoPath
        }
        self.address = address
        self.date = date
        for person in persons{
            self.addToPersons(person)
            person.addToEvents(self)
        }
    }
}
