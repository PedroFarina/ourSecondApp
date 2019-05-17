//
//  PersonCard+CoreDataClass.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//
//

import Foundation
import UIKit
import CoreData


public class PersonCard: Card {
    private let df = DateFormatter()
    
    func feed(name:String, photo:UIImage?, ratingInicial:Decimal){
        df.dateFormat = "dd-MM-yyyy hh:mm:ssZ"
        
        self.name = name
        
        if let photo = photo{
            let photoPath = df.string(from: Date())
            FileHelper.saveImage(image: photo, nameWithoutExtension: photoPath)
            self.photoPath = photoPath
        }
        
        let rating = NSEntityDescription.insertNewObject(forEntityName: "Rating", into: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext) as! Rating
        rating.feed(value: ratingInicial)
        self.addToRatings(rating)
    }
    
    func modifyDefault(newName:String?, newPhoto:UIImage?, newRating:Decimal?) -> Bool{
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
        
        if let oldRating = ratings?.array[0] as? Rating, let newRating = newRating{
            let nRating = NSDecimalNumber(decimal: newRating)
            if nRating != oldRating.value{
                oldRating.value = nRating
                hasModifications = true
            }
        }
        
        return hasModifications
    }
    
    func rating() -> Decimal{
        var media:Decimal = 0
        let ratings:[Rating] = self.ratings?.array as! [Rating]
        for rating in ratings{
            media += rating.value!.decimalValue
        }
        media /= Decimal(ratings.count)
        return media
    }
    
    /*func modify(newName:String?, newPhoto:UIImage?, oldRating:Rating?, newRating:Rating?) -> Bool{
        var hasModifications:Bool = false
        
        if let _ = newName{
            name = newName
            hasModifications = true
        }
        
        if let newPhoto = newPhoto{
            df.dateFormat = "dd-mm-yyyy hh:mm:ssZ"
            if let actualPhotoPath = photoPath{
                FileHelper.deleteImage(filePathWithoutExtension: actualPhotoPath)
            }
            
            let photoPath = df.string(from: Date())
            FileHelper.saveImage(image: newPhoto, nameWithoutExtension: photoPath)
            self.photoPath = photoPath
            
            hasModifications = true
        }
        if let ratings = ratings?.array{
            if let newRating = newRating{
                for i in 0..<ratings.count{
                    if oldRating! == ratings[i] as! Rating{
                        replaceRatings(at: i, with: newRating)
                        return true
                    }
                }
                fatalError()
            }
        }
        return hasModifications
    }*/
}
