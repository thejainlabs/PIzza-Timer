//
//  ViewController.swift
//  PIzza Timer
//
//  Created by Neelesh Jain on 09/03/20.
//  Copyright © 2020 Neelesh Jain. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var finalImage: UIImageView!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var tPizzaTimerGraphic: UIImageView!
    @IBOutlet weak var rPizzaTimerGraphic: UIImageView!
    @IBOutlet weak var bPizzaTimerGraphic: UIImageView!
    @IBOutlet weak var lPizzaTimerGraphic: UIImageView!
    
    var progress:Float = 0
    var myTimer: Timer?
    var progressIncrement:Float = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //hide timer graphics
        hideTimerGraphic()
        
    }

    @IBAction func PizzaSelectionButtonPressed(_ sender: UIButton) {
        
        print(sender.tag)
        progressBar.setProgress(0, animated: true)
        progressIncrement = 0
        progress = 0
        finalImage.isHidden = true
        //starting the graphic
        startTimerGraphic()
        
        let buttonID = sender.tag
        
        // update Label
        updateInfoLabel(pizzaType: buttonID)
        
        var graphicCounter = 1
        
        print("\(progressIncrement)")
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            //progress bar
            self.progressBar.setProgress(self.progress, animated: true)
            
            
            //graphic
            switch graphicCounter {
            case 1:
                self.tPizzaTimerGraphic.isHidden = false
                self.rPizzaTimerGraphic.isHidden = true
                self.bPizzaTimerGraphic.isHidden = true
                self.lPizzaTimerGraphic.isHidden = true
                graphicCounter = 2
            case 2:
                self.tPizzaTimerGraphic.isHidden = true
                self.rPizzaTimerGraphic.isHidden = false
                self.bPizzaTimerGraphic.isHidden = true
                self.lPizzaTimerGraphic.isHidden = true
                graphicCounter = 3
            case 3:
                self.tPizzaTimerGraphic.isHidden = true
                self.rPizzaTimerGraphic.isHidden = true
                self.bPizzaTimerGraphic.isHidden = false
                self.lPizzaTimerGraphic.isHidden = true
                graphicCounter = 4
            case 4:
                self.tPizzaTimerGraphic.isHidden = true
                self.rPizzaTimerGraphic.isHidden = true
                self.bPizzaTimerGraphic.isHidden = true
                self.lPizzaTimerGraphic.isHidden = false
                graphicCounter = 1
            default:
                print("jlt")
            }
            
            if self.progress >= 1.0 {
                timer.invalidate()
                print("invalidate triggered")
                self.hideTimerGraphic()
                self.finalImage.isHidden = false
            }
            
            print("\(self.progress) - progress")
            self.progress += self.progressIncrement
            
        }
        
        
    }
    
    func hideTimerGraphic() {
        tPizzaTimerGraphic.isHidden = true
        rPizzaTimerGraphic.isHidden = true
        bPizzaTimerGraphic.isHidden = true
        lPizzaTimerGraphic.isHidden = true
        finalImage.isHidden = true
    }
    
    func updateInfoLabel(pizzaType keyID: Int) {
        switch keyID {
        case 1:
            infoLabel.text = "Thin Crust Pizza - 10 min"
            progressIncrement = 0.1
        case 2:
            infoLabel.text = "Cheese Filled Pizza - 15 min"
            progressIncrement = 0.075
        case 3:
            infoLabel.text = "Pan Pizza - 20 min"
            progressIncrement = 0.05
        default:
            print("wrong key pressed")
        }
    }
    
    func startTimerGraphic() {
        
    }
    
}

