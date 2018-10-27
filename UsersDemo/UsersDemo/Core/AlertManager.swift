//
//  AlertManager.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/27/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class AlertManager {
    
    static func CreateAlert(title: String, message: String, style: UIAlertController.Style) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        
        return alert
    }
    
}
