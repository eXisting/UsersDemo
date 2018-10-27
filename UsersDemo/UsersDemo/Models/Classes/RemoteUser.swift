//
//  User.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/24/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class RemoteUser : UserProtocol {
    
    var name: String?
    var surname: String?
    var email: String?
    var phone: String?
    
    var image: UIImage?
    var profileImage: UIImage?
    
    var imageWrapper: UserImageWrapper?
    
    init() {}
    
    required init(json: [String: Any]) {
        
        guard let nameJson = json[UserJsonFields.Name.rawValue] as? [String:Any] else {
            print("Error during serialization of User instance")
            return
        }
        
        self.name = nameJson[UserJsonFields.FirstName.rawValue] as? String
        self.surname = nameJson[UserJsonFields.LastName.rawValue] as? String
        
        self.phone = json[UserJsonFields.Phone.rawValue] as? String
        self.email = json[UserJsonFields.Email.rawValue] as? String
        
        guard let pictures = json[UserJsonFields.Picture.rawValue] as? [String:Any] else {
            print("Error during serialization of pictures array")
            return
        }
        
        self.imageWrapper = UserImageWrapper(json: pictures)
    }
}

