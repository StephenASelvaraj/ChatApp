//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Stephen Selvaraj on 6/26/18.
//  Copyright © 2018 Stephen Selvaraj. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBOutlet weak var userId: UITextField!
    
    @IBOutlet weak var userPassword: UITextField!
    
    
    @IBAction func LoginButtonPressed(_ sender: Any) {
        
        SVProgressHUD.show()
        
        Auth.auth().signIn(withEmail: userId.text!, password: userPassword.text!) { (result, error) in
            if error != nil
            {
                SVProgressHUD.dismiss()
                print("incorrect user name or password \(error!)")
            } else {
                SVProgressHUD.dismiss()
                print ("Login Successful")
                
                self.performSegue(withIdentifier: "GotoChatRoom", sender: self)
            }
        }
    }
    
    
}

