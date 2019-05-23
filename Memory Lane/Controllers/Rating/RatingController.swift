//
//  RatingController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class RatingController : UIViewController, RatingSetDelegate{
    @IBOutlet var imgCard:UIImageView!
    @IBOutlet var ratingStack:RatingStack!
    @IBOutlet var lblName:UILabel!
    
    var evento:EventCard? = nil
    var pessoa:PersonCard? = nil
    var pessoas:[PersonCard] = []
    var contador:Int = 0
    
    public override func viewDidLoad(){
        if let evento = evento{
            pessoas = evento.persons?.array as! [PersonCard]
            navigationItem.title = "Avaliar \(evento.name ?? "Evento")"
        }
        if let pessoa = pessoa{
            pessoas.append(pessoa)
        }
        ratingStack.setDelegate(delegate: self)
        atualizarInfos()
    }
    
    func atualizarInfos(){
        if contador < pessoas.count{
            pessoa = pessoas[contador]
            ratingStack.resetValue()
            lblName.text = pessoa!.name
            imgCard.image = UIImage(named: GeneralProperties.personPlaceHolder)
            
            if let path = pessoa!.photoPath{
                let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
                if let answer = answer{
                    imgCard.image = UIImage(contentsOfFile:answer)
                }
            }
            contador += 1
        }
        else{
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func RatingDidSet(){
        let rating = Decimal(Double(ratingStack.value))
        if let pessoa = pessoa{
            let _ = ModelManager.shared().rateConnection(target: pessoa, rating: rating, inEvent: evento)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3, execute: {
                self.atualizarInfos()
            })
        }
        else{
            fatalError()
        }
    }
    
    @IBAction func btnCancel(sender:Any?){
        self.dismiss(animated: true, completion: nil)
    }
    
}
