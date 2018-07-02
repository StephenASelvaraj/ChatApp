//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Stephen Selvaraj on 6/25/18.
//  Copyright © 2018 Stephen Selvaraj. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import ChameleonFramework

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var messageTableView: UITableView!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var messageTextField: UITextField!

    var messageArray : [Message] = [Message]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //TODO: set yourself as delegate
        messageTableView.delegate = self
        messageTableView.dataSource = self
        
        //MARK: Do textfield height constraint code with lesson 192
        //set delegate for texfield
        messageTextField.delegate = self
        
        //register nib file
        messageTableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "customMessageCell")
        
        configureTableView()
        
        retrieveMessagesfromFirebase()
        
        messageTableView.separatorStyle = .none
        
    }
    
    /*override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }*/
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "customMessageCell", for: indexPath) as! CustomMessageCell
    
        cell.messageBody.text = messageArray[indexPath.row].messageBody
        cell.senderUsername.text = messageArray[indexPath.row].sender
        
        if cell.senderUsername.text == Auth.auth().currentUser?.email as String? {
            
            cell.avatarImageView.backgroundColor = UIColor.brown
            cell.messageBackground.backgroundColor = UIColor.flatBlue()
        } else {
            cell.avatarImageView.backgroundColor = UIColor.flatForestGreen()
            cell.messageBackground.backgroundColor = UIColor.flatBlack()
        }
        
        return cell
        
    }
    
    /*func textFieldDidBeginEditing(_ textField: UITextField) {
        
        
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 308
            self.view.layoutIfNeeded()
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.5) {
            self.heightConstraint.constant = 50
            self.view.layoutIfNeeded()
        }
    }*/
    
    //MARK: Send Button Functionality
    @IBAction func sendButton(_ sender: Any) {
        //disable duplicate click of send button and text
        messageTextField.isEnabled = false
        sendButton.isEnabled = false
        
        //TODO: Store the data in firebase
        let mydatabase = Database.database().reference().child ("Messages")
        
        let messageDictionary = ["Sender": Auth.auth().currentUser?.email,
                                 "MessageBody" : messageTextField.text! ]

        mydatabase.childByAutoId().setValue(messageDictionary) {
            (error, reference) in
            
            if (error != nil) {
                print("Error \(error!)")
            } else {
                print("message saved successfully")
                //TODO: Enable the send area to send further messages
                self.messageTextField.isEnabled = true
                self.sendButton.isEnabled = true
                self.messageTextField.text = ""
            }
        }
        
    }

    func retrieveMessagesfromFirebase () {
        let messageDB = Database.database().reference().child ("Messages")
        
        messageDB.observe(.childAdded) { (snapshot) in
            let snapshotvalue = snapshot.value as! Dictionary<String,String>
            
            let text = snapshotvalue["MessageBody"]!
            let sender = snapshotvalue["Sender"]!
            
            print(text, sender)
            
            let message = Message()
            message.messageBody = text
            message.sender = sender
            
            self.messageArray.append(message)
            self.configureTableView()
            self.messageTableView.reloadData()
            
        }
    }
    
    
    func configureTableView() {
        messageTableView.rowHeight = UITableViewAutomaticDimension
        messageTableView.estimatedRowHeight = 120
    }
    
    
    @IBAction func LogOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("Error Signing out")
        }
        
        /*guard (navigationController?.popToRootViewController(animated: true)) != nil
            else {
                print("no view controller to pop off")
                return
        }*/
    }
    
    
}
