//
//  SearchResponse.swift
//  Stock
//
//  Created by Dhiman Das on 5/2/23.
//

import Foundation

/// API response for search
struct SearchResponse : Codable {
    let count : Int
    let result : [SearchResult]
}

/// A single search result
struct SearchResult: Codable {
    let description: String
    let displaySymbol: String
    let symbol: String
    let type:  String
}
