//
//  ConexoesViewController.swift
//  Memory Lane
//
//  Created by Pedro Giuliano Farina on 15/05/19.
//  Copyright © 2019 Pedro Giuliano Farina. All rights reserved.
//

import Foundation
import UIKit

class ConexoesViewerController : UIViewController{
    var connectionAtual:PersonCard?
    {
        didSet{
            ratingTableViewController?.connection = connectionAtual
        }
    }
    
    private var ratingTableViewController:RatingTableViewController?
    
    @IBOutlet weak var contactImage: UIImageView!
    
    @IBOutlet weak var shadowView: UIView!
    
    @IBOutlet weak var lblNome: UILabel!
    
    @IBOutlet weak var lineGraphView: LineChartView!
    
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
        
        contactImage.layer.cornerRadius = contactImage.frame.height/2
        
        var notas:[Int] = []
        for i in connectionAtual?.ratings?.array as! [Rating]{
            notas.append(i.value?.intValue ?? 0)
        }
        lineGraphView.update(points: notas)
        
        if let connectionAtual = connectionAtual{
            lblNome.text = connectionAtual.name
            contactImage.layer.borderWidth = 1
            
            
            shadowView.layer.shadowOpacity = 6
            shadowView.layer.shadowRadius = 4
            shadowView.layer.shadowColor = UIColor.lightGray.cgColor
            shadowView.layer.shadowOffset = CGSize(width: 3, height: 3)
//            switch connectionAtual.rating(){
//            case 0...1:
//                contactImage.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.631372549, blue: 0.8352941176, alpha: 1)
//            case 1..<1.5:
//                contactImage.layer.borderColor = #colorLiteral(red: 0.2941176471, green: 0.631372549, blue: 0.8352941176, alpha: 1)
//            case 1.5..<2.5:
//                contactImage.layer.borderColor =  #colorLiteral(red: 0.1098039216, green: 0.5019607843, blue: 0.7490196078, alpha: 1)
//            case 2.5..<3.5:
//                contactImage.layer.borderColor = #colorLiteral(red: 0.4509803922, green: 0.3254901961, blue: 0.6352941176, alpha: 1)
//            case 3.5..<4.5:
//                contactImage.layer.borderColor = #colorLiteral(red: 0.7529411765, green: 0.168627451, blue: 0.2862745098, alpha: 1)
//            case 4.5...5:
//                contactImage.layer.borderColor = #colorLiteral(red: 0.9333333333, green: 0.1882352941, blue: 0.3843137255, alpha: 1)
//
//            default:
//              contactImage.layer.borderWidth = 0
//
//            }
            
            lineGraphView.LineColor = .red
            
            //contactImage =
            //            imgPicker.pickImage(self) { (image) in
            //                self.imgConnection.image = image
            //                self.imgChanged = true
            //            }
            
//            if var eventos = connectionAtual.events {
//                if eventos.count > 0{
//                    let df:DateFormatter = DateFormatter()
//                    df.dateFormat = "dd/MMM"
//                    eventos = eventos.reversed
//                    for i in 0 ..< min(3, eventos.count) {
//                        guard let evento = eventos[i] as? EventCard else { return }
//                        lbls[i].text = "\(evento.name ?? "Avaliação Rápida") - \(df.string(from: evento.date! as Date))"
//
//                    }
//                }
//            }
            
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
            else if let controller = navController.topViewController as? RatingController{
                controller.pessoa = connectionAtual
            }
        }
        else  if let controller = segue.destination as? RatingTableViewController{
            ratingTableViewController = controller
            controller.connection = connectionAtual
        }
    }
}
