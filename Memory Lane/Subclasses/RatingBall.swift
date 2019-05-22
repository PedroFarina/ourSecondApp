//
//  RatingView.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 22/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class RatingBall : UIView{
    @IBInspectable var fillColor:UIColor = .yellow
    @IBInspectable var emptyColor:UIColor = .clear
    
    var _value:Float = 3
    @IBInspectable var value:Float{
        get{
            return _value
        }
        set{
            _value = min(newValue, 1)
            setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        self.isUserInteractionEnabled = true
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let center = CGPoint(x:bounds.width/2, y:bounds.height/2)
        let radius = min(bounds.width/2, bounds.height/2) - 1
        var path = UIBezierPath(arcCenter: center, radius: radius, startAngle: CGFloat.zero, endAngle: 2 * CGFloat.pi, clockwise: false)
        
        emptyColor.setFill()
        path.fill()
        
        var Angles:(CGFloat, CGFloat)
        
        switch value {
        case 0.75 ..< 1:
            Angles = (5 * CGFloat.pi/3, CGFloat.pi/3)
        case 0.5 ..< 0.75:
            Angles = (3 * CGFloat.pi/2, CGFloat.pi/2)
        case 0.25 ..< 0.5:
            Angles = (4 * CGFloat.pi/3, 2 * CGFloat.pi/3)
        case 1:
            fillColor.setFill()
            path.fill()
            return
        default:
            return
        }
        path = UIBezierPath(arcCenter: center, radius: radius, startAngle: Angles.0, endAngle: Angles.1, clockwise: false)
        fillColor.setFill()
        path.fill()
    }
    
}
