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
    @IBOutlet var lastImage: UIImageView!
    var evento:EventCard? = nil
    var pessoa:PersonCard? = nil
    var rating:Int = 3
    
    public override func viewDidLoad(){
        view.layer.cornerRadius = 20
        lastImage.isHighlighted = true
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
    
    @IBAction func gestureTap(sender:UITapGestureRecognizer){
        if let image = sender.view as? UIImageView{
            lastImage.isHighlighted = false
            rating = image.tag
            image.isHighlighted = true
            lastImage = image
        }
    }
    
    @IBAction func btnDoneTap(sender:Any?){
        
    }
    
    @IBAction func btnCancel(sender:Any?){
        self.dismiss(animated: true, completion: nil)
    }
    
}
