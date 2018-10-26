//
//  User.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

enum UserValidationError: Error {
    case NameError
    case SurnameError
    case PhoneError
    case EmailError
    case ImageUrlError
}

enum UserFields: String {
    case Name = "name"
    case FirstName = "first"
    case LastName = "last"
    case Email = "email"
    case Phone = "phone"
    case Picture = "picture"
}

class User {
    
    var name: String?
    var surname: String?
    var email: String?
    var phone: String?
    var image: UIImage?

    var profileImage: UIImage?
    
    var imageWrapper: UserImageWrapper?
    
    init() {}
    
    required init(json: [String: Any]) {
        
        guard let nameJson = json[UserFields.Name.rawValue] as? [String:Any] else {
            print("Error during serialization of User instance")
            return
        }
        
        self.name = nameJson[UserFields.FirstName.rawValue] as? String
        self.surname = nameJson[UserFields.LastName.rawValue] as? String
        
        self.phone = json[UserFields.Phone.rawValue] as? String
        self.email = json[UserFields.Email.rawValue] as? String
        
        guard let pictures = json[UserFields.Picture.rawValue] as? [String:Any] else {
            print("Error during serialization of pictures array")
            return
        }
        
        self.imageWrapper = UserImageWrapper(json: pictures)
    }
}

