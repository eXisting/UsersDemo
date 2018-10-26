//
//  InputValidator.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/26/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class InputValidator {
    
    static func validateLenght(input: String) -> Bool {
        return input.count > 1 && input.count <= 30
    }
    
    static func validateWhitespaces(input: String) -> Bool {
        return input.trimmingCharacters(in:  CharacterSet.init(charactersIn: " ")).count > 0
    }
    
    static func validateEmail(input: String) -> Bool {
        // TODO
        return true
    }
    
}
