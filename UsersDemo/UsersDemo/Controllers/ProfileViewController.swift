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
    
    @IBAction func onNameEditFinished(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            print("Unexpected sender!")
            return
        }
        
        guard let text = textField.text else {
            print("Unexpected text!")
            textField.text = userInfo.name
            return
        }
        
        if !InputValidator.validateLenght(input: text) || !InputValidator.validateWhitespaces(input: text) {
            print("Wrong input!")
            textField.text = userInfo.name
            return
        }
        
        customizeTextFieldColorTo(field: textField, color:UIColor.black)
    }
    
    @IBAction func onSurnameEditFinished(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            print("Unexpected sender!")
            return
        }
        
        guard let text = textField.text else {
            print("Unexpected text!")
            textField.text = userInfo.surname
            return
        }
        
        if !InputValidator.validateLenght(input: text) || !InputValidator.validateWhitespaces(input: text) {
            print("Wrong input!")
            textField.text = userInfo.surname
            return
        }
        
        customizeTextFieldColorTo(field: textField, color:UIColor.black)
    }
    
    
    @IBAction func onEmailEditFinished(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            print("Unexpected sender!")
            return
        }
        
        guard let text = textField.text else {
            print("Unexpected text!")
            textField.text = userInfo.email
            return
        }
        
        if !InputValidator.validateEmail(input: text) {
            print("Wrong input!")
            textField.text = userInfo.email
            return
        }
        
        customizeTextFieldColorTo(field: textField, color:UIColor.black)
    }
    
    @IBAction func onPhoneEditFinished(_ sender: Any) {
        guard let textField = sender as? UITextField else {
            print("Unexpected sender!")
            return
        }
        
        customizeTextFieldColorTo(field: textField, color:UIColor.black)
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

