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
    var evento:EventCard? = nil
    var pessoa:PersonCard? = nil
    @IBOutlet var sliderRating: DesignableSlider!
    
    public override func viewDidLoad(){
        view.layer.cornerRadius = 20
        var card:Card
        if let evento = evento{
            card = evento
        }
        else{
            card = pessoa!
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
    
    @IBAction func sliderChangedValue(_ sender: Any) {
        sliderRating.thumbImage = UIImage(named: GeneralProperties.ratingPathImages[Int(sliderRating.value) - 1] + GeneralProperties.sliderSufix)
    }
    
    @IBAction func btnDoneTap(sender:Any?){
        let rating = Decimal(Int(sliderRating.value))
        if let evento = evento{
            ModelManager.shared().rateEvent(target: evento, rating: rating)
        }
        else if let pessoa = pessoa{
            ModelManager.shared().rateConnection(target: pessoa, rating: rating)
        }
        else{
            fatalError()
        }
    }
    
    @IBAction func btnCancel(sender:Any?){
        self.dismiss(animated: true, completion: nil)
    }
    
}
