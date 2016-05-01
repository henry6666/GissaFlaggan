//
//  LogInViewController.swift
//  LogInApplication
//
//  Created by Henry Aguinaga on 2016-04-13.
//  Copyright © 2016 Henry Aguinaga. All rights reserved.
//

import UIKit
import iAd
import AdSupport

class LogInViewController: UIViewController, ADBannerViewDelegate {
    
    
    
    
    @IBOutlet weak var banner: ADBannerView!
    
    
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var createAccountButton: UIButton!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var logOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.canDisplayBannerAds = true
        self.banner?.delegate = self
        self.banner?.hidden = true
        
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
                
        
        
        
        
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil && CURRENT_USER.authData != nil
        {
        
        self.logOutButton.hidden = false
            
        self.playButton.hidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        self.banner?.hidden = false
    }
    
    func bannerView(banner: ADBannerView!, didFailToReceiveAdWithError error: NSError!) {
        self.banner?.hidden = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func loginAction(sender: AnyObject){
    
    let email = self.emailTextfield.text
    let password = self.passwordTextfield.text
        
    
        if email != "" && password != "" {
        
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) in
                
                if error == nil {
                
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    
                    print("Logged In!")
                    self.logOutButton.hidden = false
                    self.playButton.hidden = false
            
                }
                else {
                
                    print(error)
                
                }
              
            })

        }
        
        else {
        
        let alert = UIAlertController(title: "Fel", message: "Skriv ditt namn och lösenord", preferredStyle: .Alert)
        
        let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        
        alert.addAction(action)
        
        self.presentViewController(alert, animated: true, completion: nil)
          
        }
  
    }

    @IBAction func logOutAction(sender: UIButton) {
        
        CURRENT_USER.unauth()
        NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
        self.logOutButton.hidden = true
        self.playButton.hidden = true
        
    }
    
    
    @IBAction func emailTextfieldActionDismiss(sender: AnyObject) {
        self.resignFirstResponder()
    
    }
    
    @IBAction func paswordTextfieldActionDismiss(sender: AnyObject) {
        self.resignFirstResponder()
    
    }
   
}
