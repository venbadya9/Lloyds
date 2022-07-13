//
//  UserDataDTO.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import Foundation

// MARK: UserDataListDTO

struct UserDataListDTO: Decodable {
    let page, perPage, total, totalPages: Int
    let data: [UserDataDTO]
    let support: SupportDataDTO

    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case total
        case totalPages = "total_pages"
        case data, support
    }
}

extension UserDataListDTO {
    struct UserDataDTO: Decodable {
        let id: Int
        let email, firstName, lastName: String
        let avatar: String

        private enum CodingKeys: String, CodingKey {
            case id, email
            case firstName = "first_name"
            case lastName = "last_name"
            case avatar
        }
    }
}

extension UserDataListDTO {
    struct SupportDataDTO: Decodable {
        let url: String
        let text: String
    }
}

extension UserDataListDTO {
    func toDmoain() -> UserDomainListDTO {
        return .init(
            page: page,
            perPage: perPage,
            total: total,
            totalPages: totalPages,
            data: data.map( { $0.toDomain() })
        )
    }
}

extension UserDataListDTO.UserDataDTO {
    func toDomain() -> UserDomainListDTO.UserDomainDTO {
        return .init(
            id: id,
            email: email,
            firstName: firstName,
            lastName: lastName,
            avatar: avatar
        )
    }
}

