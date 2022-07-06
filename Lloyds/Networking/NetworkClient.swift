//
//  NetworkClient.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 01/07/22.
//

import Foundation

enum APIError: String, Error {
    case serverError = "Server Error"
    case dataError = "Data not in correct format"
    case nilData = "Couldn't get required information"
}

protocol NetworkClientProtocol {
    func getApiData<T:Codable>(requestUrl: URL, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void)
}

class NetworkClient: NetworkClientProtocol {
    
    private var session: URLSession

    init(withSession session: URLSession = .shared) {
        self.session = session
    }
    
    func getApiData<T:Codable>(requestUrl: URL, resultType: T.Type, completion: @escaping (Result<T, APIError>) -> Void) {
        
        session.dataTask(with: requestUrl) { (responseData, httpUrlResponse, error) in
            
            if let httpResponse = httpUrlResponse as? HTTPURLResponse, httpResponse.statusCode != 200 {
                completion(.failure(.dataError))
                return
            }
            
            guard error == nil
            else { completion(.failure(.serverError)); return }
            do {
                guard let data = responseData
                else { completion(.failure(.nilData)); return }
                
                let object = try JSONDecoder().decode(T.self, from: data)
                completion(.success(object))
            } catch {
                completion(.failure(.dataError))
            }
        }.resume()
    }
}
