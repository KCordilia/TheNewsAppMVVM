//
//  URL.swift
//  News App
//
//  Created by Karim Cordilia on 22/03/2023.
//

import Foundation

extension URL {
    func addQuery(_ queryItem: String, value: String?) -> URL {
        guard var urlComponents = URLComponents(string: absoluteString) else { return absoluteURL }
        
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: queryItem, value: value)
        queryItems.append(queryItem)
        
        urlComponents.queryItems = queryItems
        return urlComponents.url!
    }
}
