//
//  Rating+CoreDataClass.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


public class Rating: NSManagedObject {
    func feed(value:Decimal){
        self.value = NSDecimalNumber(decimal:value)
        self.date = NSDate.init()
    }
    func feed(value:Decimal, date:NSDate){
        self.value = NSDecimalNumber(decimal: value)
        self.date = date
    }
    
}
