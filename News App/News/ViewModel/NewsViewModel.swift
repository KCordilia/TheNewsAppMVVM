//
//  NewsViewModel.swift
//  News App
//
//  Created by Karim Cordilia on 22/03/2023.
//

import Foundation
import Combine

enum NewsUIModel {
    case loading
    case data([NewsData])
    case error
}

final class NewsViewModel {
    private let newsService: NewsDataPublisher
    private let jsonDecoder = JSONDecoder()
    private var newsCancellable: AnyCancellable?
    
    @Published var uiModel: NewsUIModel = .loading
    
    init(newsService: NewsDataPublisher = NewsService()) {
        self.newsService = newsService
        
        try? processNewsPublisher(publisher: newsService.getTopNewsFeedPublisher())
    }
    
    func switchToAllNews() {
        uiModel = .loading
        try? processNewsPublisher(publisher: newsService.getAllNewsFeedPublisher())
    }
    
    private func processNewsPublisher(publisher: AnyPublisher<Data, URLError>) {
        newsCancellable?.cancel()
        newsCancellable = publisher.decode(type: News.self, decoder: jsonDecoder)
            .map { NewsUIModel.data($0.data) }
            .replaceError(with: NewsUIModel.error)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                self?.uiModel = model
            }
    }
}
