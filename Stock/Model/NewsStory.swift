//
//  NewsStory.swift
//  Stock
//
//  Created by Dhiman Das on 6/2/23.
//

import Foundation

/// Represent news story
struct NewsStory: Codable {
    let category: String
    let datetime: TimeInterval
    let headline: String
    let image: String
    let related: String
    let source: String
    let summary: String
    let url: String
}
