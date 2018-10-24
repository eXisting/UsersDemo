//
//  UserCell.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/23/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit
import os.log

class UserCell : UITableViewCell {
    
    // MARK: Fields
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    //    private var profilePreview: UIImageView?
//    private var phone: String?
//    private var fullName: String?
    
    // MARK: Constructors
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        
    }
    
     // MARK: Functions
    
    @IBAction func onDetailedClick(_ sender: Any) {
        
    }
    
    private func validation(_ profile: UIImageView?, _ phone: String?, _ fullname: String?) -> Bool {
        
        guard profile != nil else {
            return false
        }
        
        guard let p_Phone = phone, p_Phone.count > 0 else {
            return false
        }
        
        guard let p_FullName = fullname, p_FullName.count > 1 else {
            return false
        }
        
        return true
        
    }
    
    
}

