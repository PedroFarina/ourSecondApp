//
//  ViewController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 08/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit
import CoreData

class ViewController :UIViewController{
}

class MainViewController: UIViewController, DataModifiedDelegate, UIScrollViewDelegate {
    
    
    //Outlets
    @IBOutlet weak var status: UIView!
    @IBOutlet weak var historyGraph: LineGraphView!
    @IBOutlet weak var weekLabelStack: UIStackView!
    @IBOutlet var swipeAction: UISwipeGestureRecognizer!
    @IBOutlet weak var averageMood: UIImageView!
    @IBOutlet weak var lblAverage: UILabel!
    
    
    //Proivate Variables
    private var ratings:[Rating] = []
    private var isGraphViewShowing:Bool = false
    private var averageMoodNumber:Int = 0
    
    
    
    
    //Internal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelManager.shared().addDelegate(newDelegate: self)
        DataModified()    }
    
    public func DataModified() {
        getData()
        setupGraphDisplay()
    }
    
    private func getData(){
        ratings = ModelManager.shared().ratings
    }
    
    
    
    @IBAction func GraphViewTap(_ gesture: UIGestureRecognizer?){
        if (isGraphViewShowing) {
            //hide Graph
            UIView.transition(from: historyGraph,
                              to: status,
                              duration: 1.0,
                              options: [.transitionFlipFromLeft, .showHideTransitionViews],
                              completion:nil)
            swipeAction.direction = .left
        }else {
            //show Graph
            UIView.transition(from: status,
                              to: historyGraph,
                              duration: 1.0,
                              options: [.transitionFlipFromRight, .showHideTransitionViews],
                              completion: nil)
            swipeAction.direction = .right
        }
        isGraphViewShowing = !isGraphViewShowing
    }
    
    func setupGraphDisplay() {
        if ratings.count > 0{
            averageMoodNumber = historyGraph.update(points: fetchLastMoodValues())
            
            averageMood.image = UIImage(named: GeneralProperties.ratingPathImages[averageMoodNumber - 1] + GeneralProperties.highlightedSufix)
            var mood: String = "";
            switch averageMoodNumber {
            case 1:
                mood = "terrível"
            case 2:
                mood = "triste"
            case 3:
                mood = "neutro"
            case 4:
                mood = "feliz"
            case 5:
                mood = "perfeito"
            default:
                mood = "bugado"
            }
            lblAverage.text = "Seu mood geral é \(mood)!"
            
            let maxIndex = weekLabelStack.arrangedSubviews.count - 1
            
            let formatter = DateFormatter()
            formatter.setLocalizedDateFormatFromTemplate("MMMdd")
            
            
            for i in 0...maxIndex {
                if let label = weekLabelStack.arrangedSubviews[maxIndex - i] as? UILabel {
                    if i < ratings.count{
                        label.text = formatter.string(from: ratings[i].date! as Date)
                    }
                }
            }
        }
    }
    
    func fetchLastMoodValues() -> [Int]{
        var lastMoods:[Int] = []
        for i in 0...ratings.count-1{
            lastMoods.append(Int(ratings[i].value!.intValue))
        }
        return lastMoods
    }

}

public class RatingsController : UITableViewController, DataModifiedDelegate{
    private var ratings:[Rating] = []
    
    private func getData(){
        ratings = ModelManager.shared().ratings
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()
    }
    
    public func DataModified() {
        getData()
        tableView.reloadData()
    }
    
    public override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ratings.count
    }
    
    override public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "connectionCell1") as! ConnectionTableViewCell
        
        let formatter = DateFormatter()
        formatter.setLocalizedDateFormatFromTemplate("MMMdd")
        var mood: String = "";
        switch (ratings[indexPath.row].value) {
        case 1:
            mood = "terrível"
        case 2:
            mood = "triste"
        case 3:
            mood = "neutro"
        case 4:
            mood = "feliz"
        case 5:
            mood = "perfeito"
        default:
            mood = "bugado"
        }
        cell.textLabel?.text = mood + " " + formatter.string(from: ratings[indexPath.row].date! as Date)
        return cell
    }
}

