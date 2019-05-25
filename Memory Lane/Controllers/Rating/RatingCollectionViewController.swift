//
//  RatingCollectionViewController.swift
//  Memory Lane
//
//  Created by Rafael Galdino on 16/05/19.
//  Copyright © 2019 Galdineris. All rights reserved.
//

import UIKit

class RatingCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, DataModifiedDelegate {
    
    private var ratings:[Rating] = []
    
    var ratingIndexPath: IndexPath?
    
    func DataModified() {
        getData()
        collectionView.reloadData()
    }
    
    func getData(){
        ratings = ModelManager.shared().ratings
    }
    
    //    MARK: - Properties
    private let reuseIdentifier = "ratingCell"
    private let sectionInsets = UIEdgeInsets(top: 50.0,
                                             left: 20.0,
                                             bottom: 50.0,
                                             right: 20.0)
    private let itemsPerRow: CGFloat = 1

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        collectionView.delegate = self
        ModelManager.shared().addDelegate(newDelegate: self)
        getData()
    }
    
    func headerColor() -> UIColor{
        var mood: UIColor = .black;
        switch averageMoods() {
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
            mood = .white
        }
        return mood
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RatingHeaderView", for: indexPath) as? RatingHeaderView else { fatalError("Invalid view type")}
            
            headerView.lblHeader.backgroundColor = headerColor()
            let layout:UICollectionViewFlowLayout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
            layout.sectionHeadersPinToVisibleBounds = true
            return headerView
        default:
            assert(false, "invalid element type")
        }
        return collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "RatingHeaderView", for: indexPath)
    }
    
    
    
    func averageMoods() -> Int{
        var lastMoods:[Int] = []
        if ratings.count < 1{return 1}
        let range: Int = (ratings.count > 6 ? 7 : ratings.count) - 1
        for i in 0...range{
            lastMoods.append(Int(ratings[ratings.count - i - 1].value!.intValue))
        }
        lastMoods.reverse()
        
        return lastMoods.reduce(0, +) / 7
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(ratings.count)
        return ratings.count > 6 ? 7 : ratings.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "ratingCell",
                                                              for: indexPath) as! RatingCollectionViewCell
            
        cell.layer.cornerRadius = (cell.frame.width > cell.frame.height ? cell.frame.height : cell.frame.width)/2
        cell.imageView.image = UIImage(named: GeneralProperties.ratingPathImages[(ratings[ratings.count - indexPath.row - 1].value?.intValue ?? 1) - 1] + GeneralProperties.highlightedSufix)
        
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath == ratingIndexPath{
            var size = collectionView.bounds.size
            size.height -= (sectionInsets.top + sectionInsets.bottom)
            size.width -= (sectionInsets.left + sectionInsets.right)
            let ratio = (size.height - view.frame.height) > (size.width - view.frame.width) ? (size.width - view.frame.width) : (size.height - view.frame.height)
            return CGSize(width: view.frame.width - ratio, height: view.frame.height - ratio)
        }
        
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sectionInsets.left
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let controller = segue.destination as? ConexoesViewerController{
            controller.connectionAtual = nil//
        }
    }

    // MARK: UICollectionViewDelegate
    
    
 
}
