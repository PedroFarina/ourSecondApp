//
//  Rating+CoreDataProperties.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 16/05/19.
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
    @NSManaged public var persons: NSSet?

}

// MARK: Generated accessors for persons
extension Rating {

    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: PersonCard)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: PersonCard)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSSet)

}
