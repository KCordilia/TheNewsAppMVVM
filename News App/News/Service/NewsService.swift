//
//  NewsService.swift
//  News App
//
//  Created by Karim Cordilia on 22/03/2023.
//

import Foundation
import Combine

struct NewsService {
    private let allNewsUrl = URL(
        string: Endpoints.all.rawValue,
        relativeTo: APIConfig.baseURL)?
        .withParameters(useLocale: false)
    
    private let topNewsUrl = URL(
        string: Endpoints.top.rawValue,
        relativeTo: APIConfig.baseURL)?
        .withParameters(useLocale: true)
}

extension NewsService: NewsDataPublisher {
    func getAllNewsFeedPublisher() throws -> AnyPublisher<Data, URLError> {
        guard let url = allNewsUrl else { throw RuntimeError("All News URL does not exist") }
        return callUrl(url)
    }
    
    func getTopNewsFeedPublisher() throws -> AnyPublisher<Data, URLError> {
        guard let url = topNewsUrl else { throw RuntimeError("Top News URL does not exist") }
        return callUrl(url)
    }
    
    private func callUrl(_ url: URL) -> AnyPublisher<Data, URLError> {
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .map { $0.data }
            .mapError { $0 as URLError }
            .eraseToAnyPublisher()
    }
}

fileprivate extension URL {
    func withParameters(useLocale: Bool) -> URL {
        self.addQuery(
            HttpHeaders.apiToken.rawValue,
            value: APIConfig.apiKey
        )
        .addQuery(
            useLocale ? HttpHeaders.locale.rawValue : HttpHeaders.language.rawValue,
            value: APIConfig.language
        )
    }
}
