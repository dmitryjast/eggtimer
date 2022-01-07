//
//  ViewController.swift
//  EggTimer
//
//  Created by Dmitry Yatsyshyn Yu on 06/01/2022.


import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var titleLable: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    let eggTimes = ["Soft": 5 * 60, "Medium": 7 * 60, "Hard": 12 * 60]
    
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0
    
    
    
    @IBAction func buttonPress(_ sender: UIButton) {
        
        timer.invalidate()
        
        let hardness = sender.currentTitle! //Soft, Medium, Hard
        
        totalTime = eggTimes[hardness]!
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLable.text = hardness
        
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func stopButton(_ sender: Any) {
        
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLable.text = "How do you like your eggs?"
        timer.invalidate()
        
    }
    
    
    // Update timer function
    
    @objc func updateCounter() {
        if secondsPassed < totalTime {
            
            secondsPassed += 1
            
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
            
        } else {
            timer.invalidate()
            titleLable.text = "DONE"
            playSound(soundName: "alarm_sound")
        }
    }
    
    // Play sound function
    
    func playSound(soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }

    
}


