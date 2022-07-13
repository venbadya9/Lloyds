//
//  DataList.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import Foundation

// MARK: UserList

struct UserList: Equatable {
    let data: [User]
}

extension UserList {
    struct User: Equatable {
        let id: Int
        let email, firstName, lastName: String
        let avatar: String
    }
}
