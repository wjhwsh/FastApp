//
//  OMDBSearchItem.swift
//  FastAssignment
//
//  Created by Jianhua Wang on 8/12/21.
//

import Foundation
struct OMDBSearchResult: Codable {
    let response: String
    let error: String?
    let search: [OMDBSearchItem]?
    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case response = "Response"
        case error = "Error"
    }
}

struct OMDBSearchItem: Codable {
    let title: String
    let year: String
    let imdbID: String
    let type: String
    let poster: String
    var imageURL: URL? {
        return URL(string: poster)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case type = "Type"
        case poster = "Poster"
        case imdbID
    }
}
