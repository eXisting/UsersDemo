//
//  UserImageProtocol.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/27/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit


enum ImageType: String {
    case Thumbnail = "thumbnail"
    case MediumImage = "medium"
    case BigImage = "big"
}

extension UIImageView {
    func roundImageBy(divider: Float) {
        self.layer.cornerRadius = self.frame.height / CGFloat(divider)
        self.clipsToBounds = true
    }
}
