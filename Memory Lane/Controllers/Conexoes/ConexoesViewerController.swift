//
//  ConexoesViewController.swift
//  Companion
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class ConexoesViewerController : ViewController{
    var connectionAtual:PersonCard?
    
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet var lbls: [UILabel]!
    
    @IBOutlet weak var lineGraphView: LineGraphView!
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.navigationBar.barTintColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool){
        super.viewDidLoad()
        
        if let path = connectionAtual?.photoPath{
            let answer:String? = FileHelper.getFile(filePathWithoutExtension: path)
            if let answer = answer{
                contactImage.image = UIImage(contentsOfFile: answer)
            }
        }
        
        lineGraphView.setMeasures(margin: CGFloat(20), topBorder: CGFloat(10), bottomBorder: CGFloat(10))
        var notas:[Int] = []
        for i in connectionAtual?.ratings?.array as! [Rating]{
            notas.append(i.value?.intValue ?? 0)
        }
        lineGraphView.update(points: notas)
        if let connectionAtual = connectionAtual{
            navigationItem.title = connectionAtual.name
            switch connectionAtual.rating(){
            case 0...1:
                navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2941176471, green: 0.631372549, blue: 0.8352941176, alpha: 1)
            case 1..<1.5:
                navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.2941176471, green: 0.631372549, blue: 0.8352941176, alpha: 1)
            case 1.5..<2.5:
                navigationController?.navigationBar.barTintColor =  #colorLiteral(red: 0.1098039216, green: 0.5019607843, blue: 0.7490196078, alpha: 1)
            case 2.5..<3.5:
                navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.4509803922, green: 0.3254901961, blue: 0.6352941176, alpha: 1)
            case 3.5..<4.5:
                navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.7529411765, green: 0.168627451, blue: 0.2862745098, alpha: 1)
            case 4.5...5:
                navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9333333333, green: 0.1882352941, blue: 0.3843137255, alpha: 1)
                
            default:
                navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.9333333333, green: 0.1882352941, blue: 0.3843137255, alpha: 1)
                
            }
            lineGraphView.LineColor = navigationController?.navigationBar.barTintColor ?? UIColor.red
            
            //contactImage =
            //            imgPicker.pickImage(self) { (image) in
            //                self.imgConnection.image = image
            //                self.imgChanged = true
            //            }
  
            if let eventos = connectionAtual.events?.array as? [EventCard]{
                if eventos.count > 0{
                    var lblI:Int = 0
                    for i in (eventos.count-1..<max(0, eventos.count-3)).reversed() {
                        lbls[lblI].text = "\(eventos[i].name ?? "Avaliação Rápida") - \(eventos[i].date!)"
                        lblI += 1
                    }
                }
            }
            
            
        }
        else{
            navigationItem.title = "Error"
        }
    }
    
    
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navController = segue.destination as? UINavigationController{
            if let controller = navController.topViewController as? ConexoesCreatorController{
                controller.connectionAtual = connectionAtual
                controller.navigationItem.title = "Editar Conexão"
                controller.navigationItem.rightBarButtonItem?.title = "Save"
            }
        }
    }
}
