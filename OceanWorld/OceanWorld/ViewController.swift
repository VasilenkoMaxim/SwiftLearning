//
//  ViewController.swift
//  OceanWorld
//
//  Created by Maxim Vasilenko on 26/12/2018.
//  Copyright © 2018 Maxim Vasilenko. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    let myWorld = OceanWorld(horizontalSize: Constants.horizontalSize, verticalSize: Constants.verticalSize,
                             referencePoint:  (x0: Constants.x0, y0: Constants.y0, z0: Constants.z0))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myWorld.initAnimals(orcaPercent: Constants.orcaPercent, tuxPercent: Constants.tuxPercent)
        startButton.buttonType = .custom
        }
    
    
    @IBOutlet weak var startButton: UIButton!
    
    
    
    @IBAction func showMessage() {
        let alertController = UIAlertController(title: "Hello", message: "You press START", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

