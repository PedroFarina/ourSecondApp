//
//  PersonCard+CoreDataProperties.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 13/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension PersonCard {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonCard> {
        return NSFetchRequest<PersonCard>(entityName: "PersonCard")
    }

    @NSManaged public var events: NSOrderedSet?
    @NSManaged public var ratings: NSOrderedSet?

}

// MARK: Generated accessors for events
extension PersonCard {

    @objc(insertObject:inEventsAtIndex:)
    @NSManaged public func insertIntoEvents(_ value: EventCard, at idx: Int)

    @objc(removeObjectFromEventsAtIndex:)
    @NSManaged public func removeFromEvents(at idx: Int)

    @objc(insertEvents:atIndexes:)
    @NSManaged public func insertIntoEvents(_ values: [EventCard], at indexes: NSIndexSet)

    @objc(removeEventsAtIndexes:)
    @NSManaged public func removeFromEvents(at indexes: NSIndexSet)

    @objc(replaceObjectInEventsAtIndex:withObject:)
    @NSManaged public func replaceEvents(at idx: Int, with value: EventCard)

    @objc(replaceEventsAtIndexes:withEvents:)
    @NSManaged public func replaceEvents(at indexes: NSIndexSet, with values: [EventCard])

    @objc(addEventsObject:)
    @NSManaged public func addToEvents(_ value: EventCard)

    @objc(removeEventsObject:)
    @NSManaged public func removeFromEvents(_ value: EventCard)

    @objc(addEvents:)
    @NSManaged public func addToEvents(_ values: NSOrderedSet)

    @objc(removeEvents:)
    @NSManaged public func removeFromEvents(_ values: NSOrderedSet)

}

// MARK: Generated accessors for ratings
extension PersonCard {

    @objc(insertObject:inRatingsAtIndex:)
    @NSManaged public func insertIntoRatings(_ value: Rating, at idx: Int)

    @objc(removeObjectFromRatingsAtIndex:)
    @NSManaged public func removeFromRatings(at idx: Int)

    @objc(insertRatings:atIndexes:)
    @NSManaged public func insertIntoRatings(_ values: [Rating], at indexes: NSIndexSet)

    @objc(removeRatingsAtIndexes:)
    @NSManaged public func removeFromRatings(at indexes: NSIndexSet)

    @objc(replaceObjectInRatingsAtIndex:withObject:)
    @NSManaged public func replaceRatings(at idx: Int, with value: Rating)

    @objc(replaceRatingsAtIndexes:withRatings:)
    @NSManaged public func replaceRatings(at indexes: NSIndexSet, with values: [Rating])

    @objc(addRatingsObject:)
    @NSManaged public func addToRatings(_ value: Rating)

    @objc(removeRatingsObject:)
    @NSManaged public func removeFromRatings(_ value: Rating)

    @objc(addRatings:)
    @NSManaged public func addToRatings(_ values: NSOrderedSet)

    @objc(removeRatings:)
    @NSManaged public func removeFromRatings(_ values: NSOrderedSet)

}
