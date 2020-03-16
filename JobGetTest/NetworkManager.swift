//
//  NetworkManager.swift
//  JobGetTest
//
//  Created by Narek on 3/3/20.
//  Copyright © 2020 nb. All rights reserved.
//

import UIKit

class NetworkManager: NSObject {

    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }

    func get<GenericResponseTypeName: Decodable>(urlString: String, completion: @escaping (GenericResponseTypeName?, _ errorMessage: String?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil, nil)
            return
        }
        session.dataTask(with: url, completionHandler: { (data, urlReponse, error) in
            var errorMessage: String?
            var response: GenericResponseTypeName?
            defer {
                completion(response, error?.localizedDescription)
            }
            
            guard let data = data, (200..<300).contains((urlReponse as? HTTPURLResponse)?.statusCode ?? 0) else {
                errorMessage = error?.localizedDescription
                return
            }
            do  {
                response = try JSONDecoder().decode(GenericResponseTypeName.self, from: data)
            } catch {
                errorMessage = error.localizedDescription
            }
        }).resume()
    }
}
