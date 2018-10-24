//
//  User.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

enum UserValidationError : Error {
    case NameError
    case SurnameError
    case PhoneError
    case EmailError
    case ImageUrlError
}

class User {
    
    var name: String
    var surname: String
    var email: String
    var phone: String
    var imageURL: String?
    
    required init(Name: String?, Surname: String?, Email: String?, Phone: String?, ImageURL: String?) throws {
        
        guard let p_Name = Name else {
            throw UserValidationError.NameError
        }
        
        guard let p_Surname = Surname else {
            throw UserValidationError.SurnameError
        }
        
        guard let p_Email = Email else {
            throw UserValidationError.EmailError
        }
        
        guard let p_Phone = Email else {
            throw UserValidationError.PhoneError
        }
        
        self.imageURL = ImageURL
        self.name = p_Name
        self.surname = p_Surname
        self.phone = p_Phone
        self.email = p_Email
        
    }
    
    
}

