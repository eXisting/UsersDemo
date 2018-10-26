//
//  UserImageWrapper.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/25/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit
import Alamofire

enum ImageFields: String {
    case Thumbnail = "thumbnail"
    case MediumImage = "medium"
    case BigImage = "big"
}

struct UserImageWrapper {
    
    // URLs
    let big: String?
    let medium: String?
    let thumb: String?
        
    init(json: [String:Any]) {
        
        self.big = json[ImageFields.BigImage.rawValue] as? String
        self.medium = json[ImageFields.MediumImage.rawValue] as? String
        self.thumb = json[ImageFields.Thumbnail.rawValue] as? String
    }
    
    func getUrlForPreview() -> String {
        return self.thumb ?? self.medium ?? self.big ?? ""
    }
}


