//
//  ViewController.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import UIKit

struct viewConst {
    static let insetTop = CGFloat(2)
    static let insetLeft = CGFloat(2)
    static let insetBottom = CGFloat(2)
    static let insetRight = CGFloat(2)
    static let minSpacingForCell = CGFloat(2)
    static let minSpacingForLine = CGFloat(2)
    static let rauseIdentifierAnimalCell = "animalCell"
}

class ViewController: UIViewController {
    
    let myWorld = OceanWorld(horizontalSize: Constants.horizontalSize, verticalSize: Constants.verticalSize, startPoint: Constants.startPoint)
    var myWorldDataSource: [String?] = []
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myWorld.initAnimals(orcaPercent: Constants.orcaPercent, tuxPercent: Constants.tuxPercent)
        self.myWorld.animalsArray.forEach { animal in self.myWorldDataSource.append(animal?.name) }
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
    }
    
    @IBAction func stepInRound(_ sender: Any) {
        /*
        repeat {
           let _ = self.myWorld.stepInRound()
        } while !self.myWorld.roundQueue.isEmpty
        self.myWorldDataSource = []
        self.myWorld.animalsArray.forEach { animal in self.myWorldDataSource.append(animal?.name) }
        self.collectionView.reloadData()
        */
        if let changedIndex = self.myWorld.stepInRound() {
            var indexPath: [IndexPath] = []
            changedIndex.forEach { index in self.myWorldDataSource[Int(index)] = self.myWorld.animalsArray[Int(index)]?.name}
            changedIndex.forEach { index in indexPath.append(IndexPath(item: Int(index), section: 0))}
            self.collectionView.reloadItems(at: indexPath)
            print(changedIndex)
            return
        }
        print("Do not site for step")
    }
    
    @IBAction func restart(_ sender: Any) {
        self.myWorld.initAnimals(orcaPercent: Constants.orcaPercent, tuxPercent: Constants.tuxPercent)
        self.myWorldDataSource = []
        self.myWorld.animalsArray.forEach { animal in self.myWorldDataSource.append(animal?.name) }
        self.collectionView.reloadData()
    }
    
    override open var shouldAutorotate: Bool {
        return false
    }
    
}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.visibleSize.width - viewConst.insetLeft - viewConst.insetRight - viewConst.minSpacingForCell*CGFloat(Constants.horizontalSize - 1))/CGFloat(Constants.horizontalSize)
        let height = (collectionView.visibleSize.height - viewConst.insetTop - viewConst.insetBottom - viewConst.minSpacingForLine*CGFloat(Constants.verticalSize - 1))/CGFloat(Constants.verticalSize)
        return CGSize(width: Int(width), height: Int(height))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: viewConst.insetTop, left: viewConst.insetLeft, bottom: viewConst.insetBottom, right: viewConst.insetRight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return viewConst.minSpacingForCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return viewConst.minSpacingForLine
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.myWorldDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: viewConst.rauseIdentifierAnimalCell, for: indexPath) as! AnimalCollectionViewCell
        if let imageName = self.myWorldDataSource[indexPath.item] {
            itemCell.imageView.image = UIImage(named: imageName)
        } else {
            itemCell.imageView.image = nil
        }
        return itemCell
    }
    
}

