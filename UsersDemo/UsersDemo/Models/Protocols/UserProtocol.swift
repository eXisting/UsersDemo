//
//  UserProtocol.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/27/18.
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

enum UserJsonFields: String {
    case Name = "name"
    case FirstName = "first"
    case LastName = "last"
    case Email = "email"
    case Phone = "phone"
    case Picture = "picture"
}

protocol UserProtocol {
    var name: String? { get set }
    var surname: String? { get set }
    var email: String? { get set }
    var phone: String? { get set }
    
    var image: UIImage? { get set }
    var profileImage: UIImage? { get set }
    
    var imageWrapper: UserImageWrapper? { get set }
}
