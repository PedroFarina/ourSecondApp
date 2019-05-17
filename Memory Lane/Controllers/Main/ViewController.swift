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

class MainViewController: UIViewController, DataModifiedDelegate {
    
    
    //Outlets
    @IBOutlet weak var historyGraph: LineGraphView!
    @IBOutlet weak var weekLabelStack: UIStackView!
    @IBOutlet weak var emojiLabelStack: UIStackView!
    
    
    //Proivate Variables
    private var ratings:[Rating] = []
    private var isGraphViewShowing:Bool = false
    private var averageMoodNumber:Int = 0
    
    
    
    
    //Internal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelManager.shared().addDelegate(newDelegate: self)
        DataModified()
        
    }
    
    public func DataModified() {
        getData()
        setupGraphDisplay()
        }
    
    private func getData(){
        ratings = ModelManager.shared().ratings
    }
    
    
    func setupGraphDisplay() {
        if ratings.count > 0{
        averageMoodNumber = historyGraph.update(points: fetchLastMoodValues())
            
            if ratings.count > 1{
                let maxIndex = weekLabelStack.arrangedSubviews.count - 1
                (weekLabelStack.arrangedSubviews[0] as? UILabel)?.font = UIFont(name: "Avenir Next Condensed", size: 12)
                let formatter = DateFormatter()
                formatter.setLocalizedDateFormatFromTemplate("MMMdd")
                
                
                for i in 0...maxIndex {
                    if let label = weekLabelStack.arrangedSubviews[maxIndex - i] as? UILabel {
                        if i < ratings.count{
                            label.text = formatter.string(from: ratings[i].date! as Date)
                            label.isHidden = false
                        }else{
                            label.isHidden = true
                        }
                    }
                }
            }
        }
        
        var mood: UIColor = .black;
        switch averageMoodNumber {
        case 1:
            mood = #colorLiteral(red: 0.2980392157, green: 0.6352941176, blue: 0.8352941176, alpha: 1)
        case 2:
            mood = #colorLiteral(red: 0.2392156863, green: 0.5019607843, blue: 0.7333333333, alpha: 1)
        case 3:
            mood = #colorLiteral(red: 0.431372549, green: 0.337254902, blue: 0.6196078431, alpha: 1)
        case 4:
            mood = #colorLiteral(red: 0.7019607843, green: 0.2235294118, blue: 0.3019607843, alpha: 1)
        case 5:
            mood = #colorLiteral(red: 0.8588235294, green: 0.2509803922, blue: 0.3960784314, alpha: 1)
        default:
            mood = historyGraph.backgroundColor ?? UIColor.white
        }
        historyGraph.LineColor = mood
//        historyGraph.endColor = historyGraph.startColor
        for i in 0...4 {
            if let image = emojiLabelStack.arrangedSubviews[4 - i] as? UIImageView {
                image.image = UIImage(named: GeneralProperties.ratingPathImages[i] + GeneralProperties.highlightedSufix)
            }
        }
    }
    
    func fetchLastMoodValues() -> [Int]{
        var lastMoods:[Int] = []
        if ratings.count < 1{return [0]}
        let range: Int = (ratings.count > 6 ? 7 : ratings.count) - 1
        for i in 0...range{
            lastMoods.append(Int(ratings[ratings.count - i - 1].value!.intValue))
        }
        lastMoods.reverse()
        
        return lastMoods
    }

}
