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
    
    func startLoadImages(_ completionHandler: @escaping (Result<UIImage>) -> Void) {
        
        requestImageBy(url: self.big) { res in
            if res.isSuccess {
                completionHandler(.success(res.value!))
            }
        }
        requestImageBy(url: self.medium) { res in
            if res.isSuccess {
                completionHandler(.success(res.value!))
            }
        }
        
        requestImageBy(url: self.thumb) { res in
            if res.isSuccess {
                completionHandler(.success(res.value!))
            }
        }
        
        completionHandler(.failure(UserValidationError.ImageUrlError))
    }
    
    private func requestImageBy(url: String?, _ completionHandler: @escaping (Result<UIImage>) -> Void) {
        
        guard let imageUrl = url else {
            print("Cannot unwrapp url or url doesn't exist!")
            return
        }
        
        RequestHandler.loadImageAsyncBy(url: imageUrl) { result in
            
            if let e = result.error {
                print(e)
                return
            }
            
            guard let m_Image = result.value else {
                print("Image was not downlaoded!")
                return
            }
            
            completionHandler(.success(m_Image))
        }
    }
}


