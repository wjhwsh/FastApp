//
//  HomeViewModel.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/12/21.
//

import UIKit

class HomeViewModel: NSObject {
    var searchResult: OMDBSearchResult?
    var service = OMDBService()
    
    var items: [OMDBSearchItem]? {
        return searchResult?.search
    }
    
    func searchOMDB(term: String, completion: @escaping (Error?)->Void) {
        service.fetchOMDB(searchTerm: term) { [weak self] (result) in
            if case .success(let omdbResult) = result {
                self?.searchResult = omdbResult
                completion(nil)
            } else if case .failure(let error) = result {
                self?.searchResult = nil
                completion(error)
            }
        }
    }
    
}
