//
//  ViewController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController {

    @IBOutlet weak var status: UIView!
    @IBOutlet weak var historyGraph: LineGraphView!
    @IBOutlet weak var weekLabelStack: UIStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    var isGraphViewShowing = false
    
    @IBAction func GraphViewTap(_ gesture: UIGestureRecognizer?){
        if (isGraphViewShowing) {
            //hide Graph
            UIView.transition(from: historyGraph,
                              to: status,
                              duration: 1.0,
                              options: [.transitionCurlDown, .showHideTransitionViews],
                              completion:nil)
        }else {
            //show Graph
            UIView.transition(from: status,
                              to: historyGraph,
                              duration: 1.0,
                              options: [.transitionCurlUp, .showHideTransitionViews],
                              completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
        setupGraphDisplay()
    }
    
    func setupGraphDisplay() {
        
        let maxDayIndex = weekLabelStack.arrangedSubviews.count - 1
        
        //  1 - replace last day with today's actual data
        historyGraph.graphPoints = fetchLastMoodValues()
        //2 - indicate that the graph needs to be redrawn
        historyGraph.setNeedsDisplay()
        
        //  3 - calculate average from graphPoints
        let average = historyGraph.graphPoints.reduce(0, +) / historyGraph.graphPoints.count
        
        // 4 - setup date formatter and calendar
        let today = Date()
        let calendar = Calendar.current
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("EEEEE")
        
        // 5 - set up the day name labels with correct days
        for i in 0...maxDayIndex {
            if let date = calendar.date(byAdding: .day, value: -i, to: today),
                let label = weekLabelStack.arrangedSubviews[maxDayIndex - i] as? UILabel {
                label.text = formatter.string(from: date)
            }
        }
    }
    
    func fetchLastMoodValues() -> [Int]{
        var lastMoods = historyGraph.graphPoints
        
        for i in 0...lastMoods.count-2{
            lastMoods[i] = lastMoods[i+1]
        }
        lastMoods[lastMoods.count - 1] =  Int.random(in: 0...5)// INSERT FETCH HERE
        
        
        return lastMoods
    }

}

