//
//  MockData.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import Foundation

struct UserListMockData {
    static let user: UserList.User = UserList.User(id: 1, email: "test@test.com", firstName: "Test", lastName: "Test", avatar: "http://www.gravatar.com/avatar")
    static let userList: UserList = UserList(data: [UserListMockData.user])
}

struct UserDomainListMockData {
    static let userDomain: UserDomainListDTO.UserDomainDTO = UserDomainListDTO.UserDomainDTO(id: 1, email: "test@test.com", firstName: "Test", lastName: "Test", avatar: "http://www.gravatar.com/avatar")
    static let userDomainList: UserDomainListDTO = UserDomainListDTO(page: 1, perPage: 1, total: 1, totalPages: 1, data: [UserDomainListMockData.userDomain])
}

struct UserDataListMockData {
    static let userData: UserDataListDTO.UserDataDTO = UserDataListDTO.UserDataDTO(id: 1, email: "test@test.com", firstName: "Test", lastName: "Test", avatar: "http://www.gravatar.com/avatar")
    static let supportData: UserDataListDTO.SupportDataDTO = UserDataListDTO.SupportDataDTO(url: "http://www.gravatar.com/avatar", text: "test")
    static let userDataList: UserDataListDTO = UserDataListDTO(page: 1, perPage: 1, total: 1, totalPages: 1, data: [UserDataListMockData.userData], support: supportData)
}
