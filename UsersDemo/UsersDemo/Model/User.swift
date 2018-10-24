//
//  User.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

enum UserValidateionError : Error {
    case NameError
    case SurnameError
    case PhoneError
    case EmailError
    case ImageUrlError
}

struct User {
    var name: String
    var surname: String
    var email: String
    var phone: String
    var imageURL: String?
    
    init(Name: String?, Surname: String?, Email: String?, Phone: String?, ImageURL: String?) throws {
        
        guard let p_Name = Name else {
            throw UserValidateionError.NameError
        }
        
        guard let p_Surname = Surname else {
            throw UserValidateionError.SurnameError
        }
        
        guard let p_Email = Email else {
            throw UserValidateionError.EmailError
        }
        
        guard let p_Phone = Email else {
            throw UserValidateionError.PhoneError
        }
        
        self.imageURL = ImageURL
        self.name = p_Name
        self.surname = p_Surname
        self.phone = p_Phone
        self.email = p_Email
        
    }
    
    
}
