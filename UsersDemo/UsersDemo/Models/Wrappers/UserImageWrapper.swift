//
//  UserImageWrapper.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/25/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

struct UserImageWrapper {
    
    // URLs
    let big: String?
    let medium: String?
    let thumb: String?
        
    init(json: [String:Any]) {
        
        self.big = json[ImageType.BigImage.rawValue] as? String
        self.medium = json[ImageType.MediumImage.rawValue] as? String
        self.thumb = json[ImageType.Thumbnail.rawValue] as? String
    }
    
    func getUrlForPreview() -> String {
        return self.thumb ?? self.medium ?? self.big ?? ""
    }
}
