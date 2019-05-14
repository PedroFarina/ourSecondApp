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


public class EventCard: Card {
    func feed(name:String, photoPath:String, address:String, date:NSDate, persons:[PersonCard]){
        self.name = name
        self.photoPath = photoPath
        self.address = address
        self.date = date
        for person in persons{
            self.addToPersons(person)
        }
    }
}
