//
//  News.swift
//  News App
//
//  Created by Karim Cordilia on 22/03/2023.
//

import Foundation

import Foundation

// MARK: - News
struct News: Codable {
    let meta: Meta
    let data: [NewsData]
}

// MARK: - Datum
struct NewsData: Codable {
    let uuid, title, description, keywords: String
    let snippet: String
    let url: String
    let imageURL: String
    let language, publishedAt, source: String
    let categories: [String]

    enum CodingKeys: String, CodingKey {
        case uuid, title, description, keywords, snippet, url
        case imageURL = "image_url"
        case language
        case publishedAt = "published_at"
        case source, categories
    }
}

// MARK: - Meta
struct Meta: Codable {
    let found, returned, limit, page: Int
}

