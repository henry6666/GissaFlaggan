//
//  GissaFlagganViewController.swift
//  GissaFlaggan
//
//  Created by Henry Aguinaga on 2016-04-07.
//  Copyright © 2016 Henry Aguinaga. All rights reserved.
//

import UIKit
import GameplayKit
import AVFoundation

class GissaFlagganViewController: UIViewController {
  
    var timer = NSTimer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    var counter = 0
    
    var stopwatchString: String = ""
    
    
    var soundPlayer: AVAudioPlayer = AVAudioPlayer()
    var countries = [String]()
    var correctAnswer = 0
    var score = 0
  
    @IBOutlet weak var tidLabel: UILabel!
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
 
        let FileLocation = NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")
        
        do {
        
            soundPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: FileLocation!))
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)

        }
        
        catch
        {
            print(error)
        }
        
        soundPlayer.play()
        
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "uk", "us" ,"argentina", "andorra", "Afghanistan", "peru"]
        
        button1.layer.borderWidth = 4
        button2.layer.borderWidth = 4
        button3.layer.borderWidth = 4
        
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor


        askQuestion()
    
        counter = 0
        tidLabel.text = String(counter)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: #selector(GissaFlagganViewController.updateCounter), userInfo: nil, repeats: true)
 
    }
    
    func updateCounter() {
        
        
        //counter += 1
        //tidLabel.text = String(counter)
        
        fractions += 1
        if fractions == 60 {
        
            seconds += 1
            fractions = 0
        
        }
        if seconds == 60 {
            minutes += 1
            seconds = 0
        }
        
        let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
        let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
        let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
        
        stopwatchString = "\(minutesString): \(secondsString):\(fractionsString)"
        tidLabel.text = stopwatchString
        
    }
    
    
    func askQuestion(action: UIAlertAction! = nil)  {
        countries = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(countries) as! [String]
        
        button1.setImage(UIImage(named: countries[0]), forState: .Normal)
        button2.setImage(UIImage(named: countries[1]), forState: .Normal)
        button3.setImage(UIImage(named: countries[2]), forState: .Normal)
        
        
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        title = countries[correctAnswer].uppercaseString
      
    }
  
    @IBAction func buttonTapped(sender: UIButton) {
        
        if sender.tag == correctAnswer {
        
            title = "Rätt"
            
            score += 1
            scoreLabel.text = String(score)
            
            
        } else {
        
            title = "Fel"
            score -= 1
            scoreLabel.text = String(score)
            
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            
        }
     
        let ac = UIAlertController(title: title, message: "Antal poäng: \(score)", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Fortsätt", style: .Default, handler: askQuestion))
     
        presentViewController(ac, animated: true, completion: nil)
       
    }
  
    @IBAction func stopButtonAction(sender: AnyObject) {
        
        soundPlayer.stop()
        timer.invalidate()
    }

}

