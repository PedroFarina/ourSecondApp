//
//  DoughnutChartView.swift
//  Memory Lane
//
//  Created by Rafael Galdino on 21/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
//@IBDesignable
class DoughnutChartView: UIView {
    
    public var chartValues:[Int] = [100]{
        didSet{
            self.setNeedsDisplay()
        }
    }
    public var chartColors: [UIColor] = []{
        didSet{
            self.setNeedsDisplay()
        }
    }
    public var arcWidth: CGFloat = 50{
        didSet{
            self.setNeedsDisplay()
        }
    }
    private var chartValuesTotal:Int{
        return chartValues.reduce(0, +)
    }
    
    override func draw(_ rect: CGRect) {
        
        //Random Color generation if not enough colors for graph
        while chartColors.count < chartValues.count{
            chartColors.append(UIColor(red: CGFloat.random(in: 0...1),
                                       green: CGFloat.random(in: 0...1),
                                       blue: CGFloat.random(in: 0...1),
                                       alpha: 1.0))
        }
        chartValues.sort()
        
        let center = CGPoint(
            x: bounds.width / 2,
            y: bounds.height / 2)
        let radius = max(bounds.width, bounds.height)
        
        var startAngle: CGFloat = 3 * CGFloat.pi/2
        var endAngle: CGFloat = 7 * CGFloat.pi/2
        
        let percentages = chartValues.map({
            (value: Int) -> Double in
            return Double(value) / Double(chartValuesTotal)
        })
        
        for i in 0...chartValues.count - 1{
            endAngle = startAngle + (2 * CGFloat.pi * CGFloat(percentages[i]))
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius/2 - arcWidth/2,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            path.lineWidth = arcWidth
            chartColors[i].setStroke()
            path.stroke()
            startAngle = endAngle
        }
    }
}
