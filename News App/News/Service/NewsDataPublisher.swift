//
//  NewsDataPublisher.swift
//  News App
//
//  Created by Karim Cordilia on 22/03/2023.
//

import Foundation
import Combine

protocol NewsDataPublisher {
    func getAllNewsFeedPublisher() throws -> AnyPublisher<Data, URLError>
    func getTopNewsFeedPublisher() throws -> AnyPublisher<Data, URLError>
}
