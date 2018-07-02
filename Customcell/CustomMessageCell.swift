//
//  CustomMessageCell.swift
//  ChatApp
//
//  Created by Stephen Selvaraj on 7/2/18.
//  Copyright © 2018 Stephen Selvaraj. All rights reserved.
//

import Foundation
import UIKit

class CustomMessageCell: UITableViewCell {
    
    
    @IBOutlet var messageBackground: UIView!
    @IBOutlet var avatarImageView: UIImageView!
    
    @IBOutlet var messageBody: UILabel!
    
    @IBOutlet var senderUsername: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    
}
