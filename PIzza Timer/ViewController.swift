//
//  ViewController.swift
//  PIzza Timer
//
//  Created by Neelesh Jain on 09/03/20.
//  Copyright © 2020 Neelesh Jain. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {

    var audioPlayer: AVAudioPlayer?
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    @IBOutlet weak var tPizzaTimerGraphic: UIImageView!
    @IBOutlet weak var rPizzaTimerGraphic: UIImageView!
    @IBOutlet weak var bPizzaTimerGraphic: UIImageView!
    @IBOutlet weak var lPizzaTimerGraphic: UIImageView!
    
    var pizzaDetails = [
        "Thin Crust": 5,
        "Cheese Filled Crust": 10,
        "Pan": 15
    ]
        
    var progress:Float = 0
    var myTimer: Timer?
    var progressIncrement:Float = 0.0
    var graphicCounter:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //hide timer graphics
        initializeView()
        
    }

    @IBAction func PizzaSelectionButtonPressed(_ sender: UIButton) {
        
        // getting the button title
        let buttonTitle = sender.currentTitle!
        
        // reset view
        initializeView()
        
        // update Label
        updateInfoLabel(pizzaType: buttonTitle)
        
        //timer
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(startTimer), userInfo: nil, repeats: true)

    }
    
    // timer function
    @objc func startTimer(timer: Timer) {
        
        //changing pizza graphic
        changeTimerGraphic()
        
        // incrementing progress bar
        changeProgressBar()
        
        // update timer label
        updateTimerLabel()
        
        if progress >= 1.0 {
            timer.invalidate()
            // play timer sound
            playBellSound()
        }
        
        
    }
    
    func playBellSound() {
        let soundURL = Bundle.main.url(forResource: "bell", withExtension: "mp3")
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundURL!)
        }
        catch {
            print("failed to load file")
        }
        audioPlayer!.play()
    }
    
    func updateTimerLabel() {
        timerLabel.text = "Completion - \(round(progress*100))%"
    }
    
    func changeProgressBar() {
        progress += progressIncrement
        self.progressBar.setProgress(self.progress, animated: true)
    }
    
    func initializeView() {
        
        // setting up info label
        infoLabel.text = "Pizza Timer"
        
        // hide timer pizza graphic
        tPizzaTimerGraphic.isHidden = true
        rPizzaTimerGraphic.isHidden = true
        bPizzaTimerGraphic.isHidden = true
        lPizzaTimerGraphic.isHidden = true
        
        //progress bar reset to zero
        progressBar.setProgress(0, animated: true)
        //setting progress to 0
        progress = 0
        
        // graphic counter reset
        graphicCounter = 1
        
        // reset timer info label
        timerLabel.text = ""
    }
    
    func updateInfoLabel(pizzaType keyID: String) {
        infoLabel.text = "\(keyID) - \(pizzaDetails[keyID]!)"
        
        // set progress for progress bar as per the selected Pizza
        progressIncrement = Float(1.0/Float(pizzaDetails[keyID]!))
        print(progressIncrement)
        
    }
    
    func changeTimerGraphic( ) {
        switch graphicCounter {
        case 1:
            self.tPizzaTimerGraphic.isHidden = false
            self.rPizzaTimerGraphic.isHidden = true
            self.bPizzaTimerGraphic.isHidden = true
            self.lPizzaTimerGraphic.isHidden = true
            graphicCounter = 2
        case 2:
            self.rPizzaTimerGraphic.isHidden = false
            graphicCounter = 3
        case 3:
            self.bPizzaTimerGraphic.isHidden = false
            graphicCounter = 4
        case 4:
            self.lPizzaTimerGraphic.isHidden = false
            graphicCounter = 1
        default:
            print("jlt")
        }
    }
    
    //resetting when touching outside
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        myTimer?.invalidate()
        initializeView()
    }
    
}

