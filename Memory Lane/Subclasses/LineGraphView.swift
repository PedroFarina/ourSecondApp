//
//  LineGraphView.swift
//  Companion
//
//  Created by Rafael Galdino on 11/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

//@IBDesignable
class LineGraphView:UIView{
    @IBInspectable var cornerRadiusSize: CGFloat = 5.0
    @IBInspectable var startColor: UIColor = .red
    @IBInspectable var endColor: UIColor = .green
    @IBInspectable var LineColor: UIColor = .white
    public var margin:CGFloat = 20.0
    public var topBorder: CGFloat = 60
    public var bottomBorder: CGFloat = 100
    
    public var graphPoints:[Int] = [4,3,5]
    
    
    override func draw(_ rect: CGRect) {
        
        let path = UIBezierPath(roundedRect: rect,
                                byRoundingCorners: .allCorners,
                                cornerRadii: CGSize(width: cornerRadiusSize, height: cornerRadiusSize))
        path.addClip()
        
        let context = UIGraphicsGetCurrentContext()!
        let colors = [startColor.cgColor, endColor.cgColor]
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let colorLocations: [CGFloat] = [0.0, 1.0]
        
        let gradient = CGGradient(colorsSpace: colorSpace,
                                  colors: colors as CFArray,
                                  locations: colorLocations)!
        
        let startPoint = CGPoint.zero
        let endPoint = CGPoint(x: 0, y: bounds.height)
        context.drawLinearGradient(gradient,
                                   start: startPoint,
                                   end: endPoint,
                                   options: [])
    
            //        Basic Lines
            let width = rect.width
            let height = rect.height
            let graphWidth = width - margin * 2 - 4
            let columnXPoint = {(column: Int) -> CGFloat in
                //Calculation of gap between points
                let spacing = graphWidth / CGFloat(self.graphPoints.count - 1)
                return CGFloat(column) * spacing + self.margin + 2
            }
    
            let graphHeight = height - topBorder - bottomBorder
            let maxValue = graphPoints.max()!
            let columnYPoint = { (graphPoint: Int) -> CGFloat in
                let y = CGFloat(graphPoint) / CGFloat(maxValue) * graphHeight
                return graphHeight + self.topBorder - y // Flip the graph
            }
    
            LineColor.setFill()
            LineColor.setStroke()
    
    
            //      Lines Gradient (if possible)
            if !colors.isEmpty{
                let graphPath = UIBezierPath()
                graphPath.move(to: CGPoint(x: columnXPoint(0),
                                           y: columnYPoint(graphPoints[0])))
                for i in 1..<graphPoints.count {
                    let nextPoint = CGPoint(x: columnXPoint(i),
                                            y: columnYPoint(graphPoints[i]))
                    graphPath.addLine(to: nextPoint)
                }
                let context = UIGraphicsGetCurrentContext()!
                context.saveGState()
    
                let clipplingPath = graphPath.copy() as! UIBezierPath
                clipplingPath.addLine(to: CGPoint(x: columnXPoint(graphPoints.count-1),
                                                  y: height))
                clipplingPath.addLine(to: CGPoint(x: columnXPoint(0),
                                                  y: height))
                clipplingPath.close()
                clipplingPath.addClip()
                let hightestYPoint = columnYPoint(maxValue)
                let graphStartPoint = CGPoint(x: margin, y: hightestYPoint)
                let graphEndPoint = CGPoint(x: margin, y: bounds.height)
                if let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: colors as CFArray, locations: [0.0, 1.0]){
                    context.drawLinearGradient(gradient,
                                               start: graphStartPoint,
                                               end: graphEndPoint,
                                               options: [])
                }
                context.restoreGState()
    
                graphPath.lineWidth = 2.0
                graphPath.stroke()
            }
    
    
            //        Value Dots
            let circleDiameter = (width > height ? height : width) * 0.02
    
            for i in 0..<graphPoints.count{
                var point = CGPoint(x: columnXPoint(i),
                                    y: columnYPoint(graphPoints[i]))
                point.x -= circleDiameter / 2
                point.y -= circleDiameter / 2
    
                let circle = UIBezierPath(ovalIn: CGRect(origin: point, size: CGSize(width: circleDiameter, height: circleDiameter)))
                circle.fill()
            }
    
            //        Guiding Lines
            let linePath = UIBezierPath()
        
            for i in 0...(graphPoints.count - 1){
                linePath.move(to: CGPoint(x: margin, y: ((graphHeight/(CGFloat(graphPoints.count - 1))) * CGFloat(i)) + topBorder))
                linePath.addLine(to: CGPoint(x: width - margin, y: ((graphHeight/(CGFloat(graphPoints.count - 1))) * CGFloat(i)) + topBorder))
            }
            linePath.move(to: CGPoint(x: margin, y: height - bottomBorder))
            linePath.addLine(to: CGPoint(x: width - margin, y: height - bottomBorder))
            let color = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.1)
            color.setStroke()
            linePath.lineWidth = 1.0
            linePath.stroke()
    
    
        }
    
    private func setGraphPoints(_ points : [Int]){
        graphPoints = points
    }
    
    public func setMeasures(margin: CGFloat, topBorder: CGFloat, bottomBorder: CGFloat){
        self.margin = margin
        self.topBorder = topBorder
        self.bottomBorder = bottomBorder
    }
    
    public func update(points: [Int]) -> Int{
        self.setGraphPoints(points)
        self.setNeedsDisplay()
//        self.setMeasures()
        return self.graphPoints.reduce(0, +) / self.graphPoints.count
        
    }
    
}
