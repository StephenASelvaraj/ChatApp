//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Stephen Selvaraj on 6/25/18.
//  Copyright © 2018 Stephen Selvaraj. All rights reserved.
//


import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPassword: UITextField!
    
    
    @IBAction func SignUpButtonClicked(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: userName.text!, password: userPassword.text!) {
            (user, error) in
        
      
            if error != nil {
                print("error \(error!))")
            
            } else {
                print("Registration Successful")
                self.performSegue(withIdentifier: "GoToChatView", sender: self)
            }
        }
    }
}

