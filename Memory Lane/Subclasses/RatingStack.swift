//
//  RatingStack.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 22/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RatingStack : UIStackView {
    @IBOutlet var RatingBalls:[RatingBall]!
    
    
    private var _value:Float = 3
    var value:Float{
        get{
            return _value
        }
        set{
            _value = min(newValue, 5.0)
            var v:Float = _value
            for i in 0 ..< RatingBalls.count{
                if v > 1{
                    v -= 1
                    RatingBalls[i].value = 1
                }
                else{
                    RatingBalls[i].value = v
                    v = 0
                }
            }
        }
    }
    
    override func awakeFromNib() {
        for ratingBall in RatingBalls{
            let tapRecognizer:UITapGestureRecognizer = UITapGestureRecognizer()
            tapRecognizer.addTarget(self, action: #selector(tapOccur(_:)))
            ratingBall.addGestureRecognizer(tapRecognizer)
            value = _value
        }
    }
    
    @objc func tapOccur(_ sender: UITapGestureRecognizer){
        if let ball = sender.view as? RatingBall{
            if let index = RatingBalls.firstIndex(of: ball){
                value = Float(index) + 1.0
            }
        }
    }
}
