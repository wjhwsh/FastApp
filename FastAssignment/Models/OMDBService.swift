//
//  OMDBService.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/12/21.
//

import Foundation
enum Endpoint: String {
    case search = "http://www.omdbapi.com/?s={term}&apikey=d89cd9dd"
}
struct OMDBService {
    func fetchOMDB(searchTerm: String, queue: DispatchQueue = .main, completion: @escaping (Result<OMDBSearchResult, Error>)->Void) {
        guard let urlString = Endpoint.search.rawValue.replacingOccurrences(of: "{term}", with: searchTerm).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) else {return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            queue.async {
                if let error = error {
                    completion(.failure(error))
                } else {
                    do {
                        let result = try JSONDecoder().decode(OMDBSearchResult.self, from: data!)
                        completion(.success(result))
                    } catch(let error) {
                        completion(.failure(error))
                    }
                }
            }
        }.resume()
    }
}
