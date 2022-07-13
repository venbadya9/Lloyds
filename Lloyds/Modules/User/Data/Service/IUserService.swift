//
//  IUserService.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 12/07/22.
//

import Foundation

protocol IUserService {
    func makeNetworkApiCall<T: Decodable>(completion: @escaping Response<T>)
}
