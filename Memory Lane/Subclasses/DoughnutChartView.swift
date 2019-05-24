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
    
    public var chartValues:[Int] = []{
        didSet{
            self.setNeedsDisplay()
        }
    }
    public var chartColors: [UIColor] = []{
        didSet{
            self.setNeedsDisplay()
        }
    }
    public var arcWidth: CGFloat = 35{
        didSet{
            self.setNeedsDisplay()
        }
    }
    private var chartValuesTotal:Int{
        return chartValues.reduce(0, +)
    }
    
    override func draw(_ rect: CGRect) {
        if chartValues.isEmpty{
            chartValues = [100]
        }
        //Random Color generation if not enough colors for graph
        while chartColors.count != chartValues.count{
            if chartColors.count < chartValues.count{
                chartColors.append(UIColor(red: CGFloat.random(in: 0...1),
                                           green: CGFloat.random(in: 0...1),
                                           blue: CGFloat.random(in: 0...1),
                                           alpha: 1.0))
            }else{
                chartValues.append(0)
            }
        }
        
//        sorting arrays based on the values
        let combined = zip(chartValues, chartColors).sorted {$0.0 < $1.0}
        let valuesSorted = combined.map {$0.0}
        let colorsSorted = combined.map {$0.1}
        
        
        let center = CGPoint(
            x: bounds.width / 2,
            y: bounds.height / 2)
        let radius = max(bounds.width, bounds.height)
        
        var startAngle: CGFloat = 3 * CGFloat.pi/2
        var endAngle: CGFloat = 7 * CGFloat.pi/2
        
        let percentages = valuesSorted.map({
            (value: Int) -> Double in
            return Double(value) / Double(chartValuesTotal)
        })
        
        for i in 0...valuesSorted.count - 1{
            endAngle = startAngle + (2 * CGFloat.pi * CGFloat(percentages[i]))
            let path = UIBezierPath(arcCenter: center,
                                    radius: radius/2 - arcWidth/2,
                                    startAngle: startAngle,
                                    endAngle: endAngle,
                                    clockwise: true)
            path.lineWidth = arcWidth
            colorsSorted[colorsSorted.count - i - 1].setStroke()
            path.stroke()
            startAngle = endAngle
        }
    }
}

@IBDesignable class ChartLabelView:UIView{
    @IBInspectable var color:UIColor = UIColor.gray
    override func draw(_ rect: CGRect) {
        let center = CGPoint(
            x: bounds.width / 2,
            y: bounds.height / 2)
        let radius = min(bounds.width, bounds.height)
        var path = UIBezierPath(arcCenter: center,
                                    radius: radius/2 - 2,
                                    startAngle: CGFloat.zero,
                                    endAngle: 2 * CGFloat.pi,
                                    clockwise: false)
        color.setFill()
        path.fill()
    }
}

@IBDesignable class DisclosureIndicatorView:UIView{
    @IBInspectable var color:UIColor = UIColor.gray
    override func draw(_ rect: CGRect) {
        self.backgroundColor = UIColor.clear
        let center = CGPoint(
            x: 2 * bounds.width / 3,
            y: bounds.height / 2)
        
        let path = CGMutablePath()
        
        if let context = UIGraphicsGetCurrentContext(){
            
            context.saveGState()
            
            context.setLineCap(.round)
            context.setLineWidth(2)
            path.addLines(between: [center, CGPoint(x: center.x - bounds.width/3, y: center.y + bounds.height/5)])
            path.addLines(between: [center, CGPoint(x: center.x - bounds.width/3, y: center.y - bounds.height/5)])
            color.setStroke()
            context.addPath(path)
            context.strokePath()
            
            context.restoreGState()
        }
    }
}
