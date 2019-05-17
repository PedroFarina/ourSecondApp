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
        }
    }
    
    func modifyDefault(newName:String?, newPhoto:UIImage?, newAddress:String?, newDate:NSDate?, persons:[PersonCard]) -> Bool{
        var hasModifications:Bool = false
        
        if let newName = newName{
            if newName != name{
                name = newName
                hasModifications = true
            }
        }
        
        if let newPhoto = newPhoto{
            df.dateFormat = "dd-MM-yyyy hh:mm:ssZ"
            if let actualPhotoPath = photoPath{
                let _ = FileHelper.deleteImage(filePathWithoutExtension: actualPhotoPath)
            }
            
            let photoPath = df.string(from: Date())
            FileHelper.saveImage(image: newPhoto, nameWithoutExtension: photoPath)
            self.photoPath = photoPath
            
            hasModifications = true
        }
        
        if let newAddress = newAddress{
            if newAddress != address{
                address = newAddress
            }
        }
        
        if let newDate = newDate{
            if newDate != date{
                date = newDate
            }
        }
        
        if persons.hashValue != (self.persons!.array as! [PersonCard]).hashValue{
            
            if let rating = rating{
                for p in self.persons?.array as! [PersonCard]{
                    p.removeFromRatings(rating)
                }
            }
            self.removeFromPersons(self.persons!)
            for person in persons{
                self.addToPersons(person)
            }
            
            if let rating = rating{
                for p in self.persons?.array as! [PersonCard]{
                    p.addToRatings(rating)
                }
            }
            hasModifications = true
        }
        
        return hasModifications
    }
}
