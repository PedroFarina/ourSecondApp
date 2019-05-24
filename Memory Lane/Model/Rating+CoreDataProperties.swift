//
//  Rating+CoreDataProperties.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 24/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension Rating {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Rating> {
        return NSFetchRequest<Rating>(entityName: "Rating")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var value: NSDecimalNumber?
    @NSManaged public var event: EventCard?
    @NSManaged public var person: PersonCard?

}
