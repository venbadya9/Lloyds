//
//  IUserRepository.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation

protocol IUserRepository {
    func makeServiceCallToFetchDetails(completion: @escaping DataResponse)
}
