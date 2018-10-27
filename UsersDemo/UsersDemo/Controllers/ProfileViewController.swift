//
//  ProfileViewController.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userInfo: RemoteUser!
    
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
    
   
    @IBAction func onFirstNameFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            print("Unexpected text!")
            nameField.text = userInfo.name
            return
        }
        
        if !InputValidator.validateLenght(input: text) || !InputValidator.validateWhitespaces(input: text) {
            print("Wrong input!")
            nameField.text = userInfo.name
            return
        }
        
        customizeTextFieldColorTo(field: nameField, color: userInfo.name != text ? UIColor.black : UIColor.lightGray)
    }
    
    
    @IBAction func onLastNameFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            print("Unexpected text!")
            surnameField.text = userInfo.surname
            return
        }
        
        if !InputValidator.validateLenght(input: text) || !InputValidator.validateWhitespaces(input: text) {
            print("Wrong input!")
            sender.text = userInfo.surname
            return
        }
        
        customizeTextFieldColorTo(field: surnameField, color: userInfo.surname != text ?UIColor.black : UIColor.lightGray)
    }
    
    
    @IBAction func onEmailFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            print("Unexpected text!")
            emailField.text = userInfo.email
            return
        }
        
        if !InputValidator.validateEmail(input: text) {
            print("Wrong input!")
            emailField.text = userInfo.email
            return
        }
        
        customizeTextFieldColorTo(field: emailField, color: userInfo.email != text ?UIColor.black : UIColor.lightGray)
    }
    
    
    @IBAction func onPhoneFieldChanged(_ sender: UITextField) {
        guard let text = sender.text else {
            print("Unexpected text!")
            phoneField.text = userInfo.email
            return
        }
        
        if !InputValidator.validateEmail(input: text) {
            print("Wrong input!")
            phoneField.text = userInfo.email
            return
        }
        
        customizeTextFieldColorTo(field: phoneField, color: userInfo.email != text ?UIColor.black : UIColor.lightGray)
    }
    
    
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
        profileImage.image = userInfo.profileImage!
        
        profileImage.roundImageBy(divider: 2.0)
    }
    
    private func customizeTextFieldColorTo(field: UITextField, color: UIColor) {
        field.textColor = color
    }
}

