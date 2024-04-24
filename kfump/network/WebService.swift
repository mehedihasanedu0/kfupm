//
//  WebService.swift
//  kfump
//
//  Created by Mehedi Hasan on 24/4/24.
//

import Foundation
import UIKit

enum NetworkError: Error {
    case decodingError
    case domainError
    case urlError
    case nullData
    case data
    case offline
    case invalidURL
    case undefined
    
}

enum Result<T,H> {
    case success(T,H)
    case failure(H)
}

enum HttpMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

typealias HandlerResult = Result<Data,Error>
