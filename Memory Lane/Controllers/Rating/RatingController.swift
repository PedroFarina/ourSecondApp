//
//  RatingController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class RatingController : UIViewController{
    @IBOutlet var imgCard:UIImageView!
    @IBOutlet var ratingStack:RatingStack!
    var evento:EventCard? = nil
    var pessoa:PersonCard? = nil
    
    public override func viewDidLoad(){
        view.layer.cornerRadius = 20
        var card:Card
        if let evento = evento{
            card = evento
            imgCard.image = UIImage(named: GeneralProperties.eventPlaceHolder)
        }
        else{
            card = pessoa!
            imgCard.image = UIImage(named: GeneralProperties.personPlaceHolder)
        }
        if let name = card.name{
            navigationItem.title = "Avaliar \(name)"
        }
        if let path = card.photoPath{
            let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
            if let answer = answer{
                imgCard.image = UIImage(contentsOfFile:answer)
            }
        }
    }
    
    @IBAction func btnDoneTap(sender:Any?){
        let rating = Decimal(Double(ratingStack.value))
        if let evento = evento{
            let _ = ModelManager.shared().rateEvent(target: evento, rating: rating)
        }
        else if let pessoa = pessoa{
            let _ = ModelManager.shared().rateConnection(target: pessoa, rating: rating)
        }
        else{
            fatalError()
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(sender:Any?){
        self.dismiss(animated: true, completion: nil)
    }
    
}
