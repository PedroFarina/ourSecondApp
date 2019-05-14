//
//  Card+CoreDataProperties.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
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
