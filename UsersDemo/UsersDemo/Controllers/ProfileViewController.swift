//
//  ProfileViewController.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var userInfo: UserProtocol!
    let persistenceManager: PersistenceManager
    
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
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.persistenceManager = PersistenceManager.instance
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.persistenceManager = PersistenceManager.instance
        super.init(coder: aDecoder)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var tabIndex = 0
        if segue.identifier == "showSaved" {
            tabIndex = 1
            onSaveClick()
        }
        
        if let tabController  = segue.destination as? UITabBarController {
            tabController.selectedIndex = tabIndex
        }
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
    
    private func onSaveClick() {
        // either save or update user
        if let s_User = userInfo as? SavedUser {
            s_User.setValue(nameField?.text, forKey: SavedUserFields.FirstName.rawValue)
            s_User.setValue(surnameField?.text, forKey: SavedUserFields.LastName.rawValue)
            s_User.setValue(emailField?.text, forKey: SavedUserFields.Email.rawValue)
            s_User.setValue(phoneField?.text, forKey: SavedUserFields.Phone.rawValue)
            
            let i_Tuple = convertImagesToData(profileImage: profileImage?.image, thumb: userInfo.image)
            
            s_User.setValue(i_Tuple.full, forKey: SavedUserFields.FullImage.rawValue)
            s_User.setValue(i_Tuple.thumb, forKey: SavedUserFields.Thumbnail.rawValue)
            print("Updated user successfuly!")
        } else {
            let user = SavedUser.init(context: self.persistenceManager.context)
            user.name = nameField?.text
            user.surname = surnameField?.text
            user.email = emailField?.text
            user.phone = phoneField?.text
            
            setImagesDataFor(userContext: user, profileImage: profileImage?.image, thumb: userInfo.image)
            
            persistenceManager.save()
        }
    }
    
    private func initializeFields() {
        nameField?.text = userInfo.name ?? ""
        surnameField?.text = userInfo.surname ?? ""
        emailField?.text = userInfo.email ?? ""
        phoneField?.text = userInfo.phone ?? ""
        profileImage?.image = userInfo.profileImage
        
        profileImage.roundImageBy(divider: 2.0)
    }
    
    private func customizeTextFieldColorTo(field: UITextField, color: UIColor) {
        field.textColor = color
    }
    
    private func setImagesDataFor(userContext: SavedUser, profileImage:UIImage?, thumb: UIImage?) {
        
        // create NSData from UIImage
        let dataTuple = convertImagesToData(profileImage: profileImage, thumb: thumb)
        
        userContext.fullImage = dataTuple.full
        userContext.thumbnail = dataTuple.thumb
    }
    
    private func convertImagesToData(profileImage:UIImage?, thumb: UIImage?) -> (full: NSData?, thumb: NSData?) {
        var result : (full: NSData?, thumb: NSData?)
        
        guard let imageData = profileImage?.jpegData(compressionQuality: 1) else {
            // handle failed conversion
            print("jpg error")
            return result
        }
        
        result.full = imageData as NSData
        
        guard let thumbnailData  = thumb?.jpegData(compressionQuality: 1) else {
            // handle failed conversion
            print("jpg error")
            return result
        }
        
        result.thumb = thumbnailData as NSData
        
        return result
    }
}

