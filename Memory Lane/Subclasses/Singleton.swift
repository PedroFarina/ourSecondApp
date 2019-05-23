//
//  Singleton.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 09/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class ModelManager{
    // MARK: Basic properties to make a Singleton
    private init(){
        context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        do{
            _events = try context.fetch(EventCard.fetchRequest())
            _connections = try context.fetch(PersonCard.fetchRequest())
            _ratings = try context.fetch(Rating.fetchRequest())
        }
        catch{
            fatalError("Não foi possível recuperar os dados.")
        }
    }
    
    class func shared() -> ModelManager{
        return sharedContextManager
    }
    
    private static var sharedContextManager : ModelManager = {
        let contextManager = ModelManager()
        
        return contextManager
    }()
    
    // Mark: Properties
    private let context:NSManagedObjectContext
    private var _connections:[PersonCard]
    private var _events:[EventCard]
    private var _ratings:[Rating]
    private var delegates:[DataModifiedDelegate] = []
    public func addDelegate(newDelegate:DataModifiedDelegate){
        delegates.append(newDelegate)
    }
    private func notify(){
        for del in delegates{
            del.DataModified()
        }
    }
    
    // MARK: Connections Accessors
    public var connections:[PersonCard]{
        get {
            var copy:[PersonCard] = []
            copy.append(contentsOf: _connections)
            return copy
        }
    }
    //Add
    public func addConnection(name:String, photo:UIImage?, ratingInicial:Decimal) -> ModelStatus{
        let newConnection = NSEntityDescription.insertNewObject(forEntityName: "PersonCard", into: context) as! PersonCard
        newConnection.feed(name: name, photo: photo, ratingInicial: ratingInicial)
        _connections.append(newConnection)
        _ratings.append(newConnection.ratings?.firstObject as! Rating)
        do{
            try context.save()
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possível salvar uma nova conexão.")
        }
        notify()
        return ModelStatus(successful: true)
    }
    //Edit
    public func editInitialConnection(target:PersonCard, newName:String?, newPhoto:UIImage?, newRating:Decimal) -> ModelStatus{
        if target.modifyDefault(newName: newName, newPhoto: newPhoto, newRating: newRating){
            do{
                try context.save()
                _ratings = try context.fetch(Rating.fetchRequest())
                notify()
                return ModelStatus(successful: true)
            }
            catch{
                return ModelStatus(successful: false, description: "Não foi possível editar a conexão")
            }
        }
        return ModelStatus(successful: true, description: "Não houve modificações")
    }
    //Remove
    public func removeConnection(at:Int) -> ModelStatus{
        if at < _connections.count && at >= 0{
            if let photoPath = _connections[at].photoPath{
                let _ = FileHelper.deleteImage(filePathWithoutExtension: photoPath)
            }
            context.delete(_connections[at])
            _connections.remove(at: at)
            do{
                try context.save()
                _ratings = try context.fetch(Rating.fetchRequest())
                notify()
                return ModelStatus(successful: true)
            }
            catch{
                return ModelStatus(successful: false, description: "Não foi possível deletar a conexão")
            }
        }
        return ModelStatus(successful: false, description: "O index desejado está fora da range")
    }
    
    // MARK: Events Accessors
    public var events:[EventCard]{
        get{
            var copy:[EventCard] = []
            copy.append(contentsOf: _events)
            return copy
        }
    }
    //Add
    public func addEvent(name:String, photo:UIImage?, address:String?, date:NSDate, persons:[PersonCard]) -> ModelStatus{
        let newEvent = NSEntityDescription.insertNewObject(forEntityName: "EventCard", into: context) as! EventCard
        newEvent.feed(name: name, photo: photo, address: address, date: date, persons: persons)
        _events.append(newEvent)
        do{
            try context.save()
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possível salvar um novo evento.")
        }
        notify()
        return ModelStatus(successful: true)
    }
    //Edit
    public func editEvent(target:EventCard, newName:String?, newPhoto:UIImage?, newAddress:String?, newDate:NSDate?, persons:[PersonCard]) -> ModelStatus{
        if target.modifyDefault(newName: newName, newPhoto: newPhoto, newAddress: newAddress, newDate: newDate, persons: persons){
            do{
                try context.save()
                notify()
                return ModelStatus(successful: true)
            }
            catch{
                return ModelStatus(successful: false, description: "Não foi possível editar o evento")
            }
        }
        
        return ModelStatus(successful: true, description: "Não houve modificações")
    }
    //Remove
    public func removeEvent(at:Int) -> ModelStatus{
        if at < _events.count && at >= 0 {
            context.delete(_events[at])
            do{
                try context.save()
                _ratings = try context.fetch(Rating.fetchRequest())
                notify()
                return ModelStatus(successful: true)
            }
            catch{
                return ModelStatus(successful: false, description: "Não foi possível deletar o evento")
            }
        }
        return ModelStatus(successful: false, description: "O index desejado está fora da range")
    }
    
    // MARK: Ratings Accessors
    public var ratings:[Rating]{
        get{
            var copy:[Rating] = []
            copy.append(contentsOf: _ratings)
            return copy
        }
    }
    
    //Rating Connections
    public func rateConnection(target:PersonCard,rating ratingValue:Decimal, inEvent event:EventCard?) -> ModelStatus{
        let rating = NSEntityDescription.insertNewObject(forEntityName: "Rating", into: context) as! Rating
        rating.value = NSDecimalNumber(decimal:ratingValue)
        if let event = event{
            rating.event = event
        }
        rating.date = NSDate()
        target.addToRatings(rating)
        _ratings.append(rating)
        do{
            try context.save()
            notify()
            return ModelStatus(successful: true)
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possível avaliar a pessoa")
        }
    }
    
    //Rating Events
    public func rateEvent(target:EventCard, rating ratingValue:Decimal) -> ModelStatus{
        var rating:Rating!
        if let oldRating = target.rating{
            rating = oldRating
            _ratings.remove(at: _ratings.firstIndex(of: rating)!)
        }
        else{
            rating = (NSEntityDescription.insertNewObject(forEntityName: "Rating", into: context) as! Rating)
        }
        target.rating = rating
        rating.value = NSDecimalNumber(decimal: ratingValue)
        rating.date = NSDate()
        
        _ratings.append(rating)
        do{
            try context.save()
            notify()
            return ModelStatus(successful: true)
        }
        catch{
            return ModelStatus(successful: false, description: "Não foi possível avaliar o evento")
        }
    }
}
