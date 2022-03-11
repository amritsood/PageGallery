//
//  NetworkManager.swift
//  PhotoGallery
//
//  Created by user on 11/03/22.
//

import Foundation

/*
 Singleton class to manage network calls
 */

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {
        // private initializer
    }
    
    // GET Request Method
    func getRequest<T: Decodable>(_ modal: T.Type,
                                 with path: URL.Path,
                                 completion: @escaping (Result<T,ServerError>) -> Void ) {
        
        guard let url = path.url else {
            completion(.failure(.invalidUrl)) // invalid url request
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let authorization = "Client-ID \(Constants.KCLIENT_ID)"
        request.setValue(authorization, forHTTPHeaderField: "Authorization")
        
        let session = URLSession.shared
        let task = session.dataTask(with: request) { [weak self] data, response, error in
            
            guard let _ = self else { return }
            guard let _ = response else {
                completion(.failure(.serverError))
                return
            }
            
            if let data = data,
               let response = try? JSONDecoder().decode(T.self, from: data){
                completion(.success(response))
            }
            else if let error = error {
                completion(.failure(.custom(error.localizedDescription)))
            }
            else {
                completion(.failure(.parseError))
            }
        }
        
        task.resume()
    }
}
