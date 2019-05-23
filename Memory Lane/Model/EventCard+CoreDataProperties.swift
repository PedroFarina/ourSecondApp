//
//  EventCard+CoreDataProperties.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 23/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension EventCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EventCard> {
        return NSFetchRequest<EventCard>(entityName: "EventCard")
    }

    @NSManaged public var address: String?
    @NSManaged public var date: NSDate?
    @NSManaged public var persons: NSOrderedSet?
    @NSManaged public var rating: Rating?

}

// MARK: Generated accessors for persons
extension EventCard {

    @objc(insertObject:inPersonsAtIndex:)
    @NSManaged public func insertIntoPersons(_ value: PersonCard, at idx: Int)

    @objc(removeObjectFromPersonsAtIndex:)
    @NSManaged public func removeFromPersons(at idx: Int)

    @objc(insertPersons:atIndexes:)
    @NSManaged public func insertIntoPersons(_ values: [PersonCard], at indexes: NSIndexSet)

    @objc(removePersonsAtIndexes:)
    @NSManaged public func removeFromPersons(at indexes: NSIndexSet)

    @objc(replaceObjectInPersonsAtIndex:withObject:)
    @NSManaged public func replacePersons(at idx: Int, with value: PersonCard)

    @objc(replacePersonsAtIndexes:withPersons:)
    @NSManaged public func replacePersons(at indexes: NSIndexSet, with values: [PersonCard])

    @objc(addPersonsObject:)
    @NSManaged public func addToPersons(_ value: PersonCard)

    @objc(removePersonsObject:)
    @NSManaged public func removeFromPersons(_ value: PersonCard)

    @objc(addPersons:)
    @NSManaged public func addToPersons(_ values: NSOrderedSet)

    @objc(removePersons:)
    @NSManaged public func removeFromPersons(_ values: NSOrderedSet)

}
