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
    
    var soundPlayer: AVAudioPlayer = AVAudioPlayer()

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    
    
    
    
    var countries = [String]()
    var correctAnswer = 0
    var score = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let FileLocation = NSBundle.mainBundle().pathForResource("music", ofType: ".mp3")
        
        do {
        
            soundPlayer = try AVAudioPlayer(contentsOfURL: NSURL(fileURLWithPath: FileLocation!))
            
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryAmbient)
            try AVAudioSession.sharedInstance().setActive(true)
        
        }
        
        catch {
            print(error)
        }
        
        soundPlayer.play()
        
        
        

        
//        countries.append("estonia")
//        countries.append("france")
//        countries.append("germany")
//        countries.append("ireland")
//        countries.append("italy")
//        countries.append("monaco")
//        countries.append("nigeria")
//        countries.append("poland")
//        countries.append("russia")
//        countries.append("uk")
//        countries.append("us")
        
        
        countries += ["estonia", "france", "germany", "ireland", "italy", "monaco", "nigeria", "poland", "russia", "uk", "us" ,"argentina", "andorra", "Afghanistan", "peru"]
        
        button1.layer.borderWidth = 4
        button2.layer.borderWidth = 4
        button3.layer.borderWidth = 4
        
        button1.layer.borderColor = UIColor.lightGrayColor().CGColor
        button2.layer.borderColor = UIColor.lightGrayColor().CGColor
        button3.layer.borderColor = UIColor.lightGrayColor().CGColor


        askQuestion()
      
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
        
        
        let ac = UIAlertController(title: title, message: "Your Score Is: \(score)", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
        
        presentViewController(ac, animated: true, completion: nil)
       
    }
    
    
    @IBAction func stopButtonAction(sender: AnyObject) {
        
        soundPlayer.stop()
    }
    
    
    

}



