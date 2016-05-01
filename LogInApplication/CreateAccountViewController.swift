//
//  CreateAccountViewController.swift
//  LogInApplication
//
//  Created by Henry Aguinaga on 2016-04-13.
//  Copyright © 2016 Henry Aguinaga. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {
    
    @IBOutlet weak var imailTextfiel: UITextField!
    
    @IBOutlet weak var passwordTextfield: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func createAccountAction(sender: AnyObject) {
        
        let email = self.imailTextfiel.text
        let password = self.passwordTextfield.text
        
        
        if email != "" && password != ""
        {
            FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, authData) in
                if error == nil
                {
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) in
                        if error == nil
                        {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            print("Ditt konto är skapat!")
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                            
                        } else {
                            
                            print(error)
                        }
                    })
                }
                else {
                
                    print(error)
                }
            })
        }
        else
        {
            let alert = UIAlertController(title: "Error", message: "Skriv ditt Email och lösenord", preferredStyle: .Alert)
            
            let action = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alert.addAction(action)
            
            self.presentViewController(alert, animated: true, completion: nil)
            
            
        
        }
        
        
    }
    
    @IBAction func cancelAction(sender: AnyObject) {
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    
    @IBAction func emailFieldActionDismiss(sender: AnyObject) {
        self.resignFirstResponder()
        
    }
    
    @IBAction func passwordActionDismiss(sender: AnyObject) {
        self.resignFirstResponder()
    }

}
