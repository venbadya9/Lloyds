//
//  UsewrCellViewModel.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation

struct UserCellViewModel {

    let email: String
    let fullName: String
    let avatar: String
    
    init(_ email: String, _ firstName: String, _ lastName: String, _ avatar: String) {
        self.email = email
        self.fullName = firstName + " " + lastName
        self.avatar = avatar
    }
}
