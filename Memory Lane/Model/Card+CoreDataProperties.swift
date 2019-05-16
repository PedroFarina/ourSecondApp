//
//  Card+CoreDataProperties.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 16/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import CoreData


extension Card {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Card> {
        return NSFetchRequest<Card>(entityName: "Card")
    }

    @NSManaged public var name: String?
    @NSManaged public var photoPath: String?

}
