//
//  RuntimeError.swift
//  News App
//
//  Created by Karim Cordilia on 22/03/2023.
//

import Foundation

struct RuntimeError: Error {
    let message: String
    init(_ message: String) {
        self.message = message
    }
    public var localizedDescription: String {
        message
    }
}
