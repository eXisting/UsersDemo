//
//  ProfileViewController.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userInfo: User!
    
    // MARK: Outlets
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeFields()
    }
    
    // MARK: Functions
        
    @IBAction func onBackClick(_ sender: Any) {
        //TODO
    }
    
    @IBAction func onSaveClick(_ sender: Any) {
        //TODO
    }
    
    private func initializeFields() {
        nameField?.text = userInfo.name ?? ""
        surnameField?.text = userInfo.surname ?? ""
        emailField?.text = userInfo.email ?? ""
        phoneField?.text = userInfo.phone ?? ""
    }
}

