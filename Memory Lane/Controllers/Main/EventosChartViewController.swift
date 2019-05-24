//
//  EventosChartViewController.swift
//  Memory Lane
//
//  Created by Rafael Galdino on 24/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import UIKit

class EventosChartViewController: UIViewController, DataModifiedDelegate{
    
    private var dados:[EventCard] = []
    
    @IBOutlet weak var ratingsChart: DoughnutChartView!
    @IBOutlet weak var colorsLabelsStackView: UIStackView!
    @IBOutlet weak var numberOfRatingsStackView: UIStackView!
    @IBOutlet weak var lblWarning: UILabel!
    
    
    //Internal Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        ModelManager.shared().addDelegate(newDelegate: self)
        DataModified()
        setupChart()
        if dados.isEmpty{
            lblWarning.text = "Nenhuma avaliação encontrada"
        }else{
            lblWarning.text = "\(ratingsChart.chartValues.reduce(0,+)) Avaliações"
        }
    }
    
    public func DataModified() {
        getData()
        setupChart()
    }
    
    private func getData(){
        dados = ModelManager.shared().events
    }
    
    public func updateChart(){
        ratingsChart.chartValues = getQtdOfRatings()
        
        for i in 0...4{
            if let lbl = numberOfRatingsStackView.arrangedSubviews[i] as? UILabel{
                lbl.text = String(ratingsChart.chartValues[i])
            }
        }
        
    }
    
    public func setupChart(){
        ratingsChart.chartColors = [
            //3E5D94 - %100
            UIColor(red: 62/255,
                    green: 93/255,
                    blue: 148/255,
                    alpha: 1.0),
            //3E5D94 - %71
            UIColor(red: 62/255,
                    green: 93/255,
                    blue: 148/255,
                    alpha: 0.71),
            //3E5D94 - %35
            UIColor(red: 62/255,
                    green: 93/255,
                    blue: 148/255,
                    alpha: 0.35),
            //918088 - %47
            UIColor(red: 151/255,
                    green: 151/255,
                    blue: 151/255,
                    alpha: 0.47),
            //918088 - %100
            UIColor(red: 151/255,
                    green: 151/255,
                    blue: 151/255,
                    alpha: 1.0)]
        
        ratingsChart.arcWidth = min(ratingsChart.frame.height, ratingsChart.frame.width)/5
        
        for i in 0...4{
            if let lbl = colorsLabelsStackView.arrangedSubviews[i] as? ChartLabelView{
                lbl.colour = ratingsChart.chartColors[i]
            }
            
        }
        updateChart()
    }
    
    private func getQtdOfRatings() -> [Int]{
        var ratingsValues:[Int] = [0,0,0,0,0]
        for i in dados{
            if let x = i.rating?.value?.intValue{
                ratingsValues[x-1] += 1
            }
        }
        return ratingsValues.reversed()
    }
    
}
