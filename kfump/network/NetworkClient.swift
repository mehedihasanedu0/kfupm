//
//  NetworkClient.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/4/24.
//

import Foundation
import SwiftUI
import Combine


class NetworkClient {
    static let shared = NetworkClient()
    @AppStorage("x-api-token") private var token = ""
    var accessToken: String = (UserDefaults.standard.string(forKey: "accessToken") ?? accessTokenInfo)
    
    private func APIURLRequest(url: URL, method: String, headers: [String: String]?, body: Data?, headerDetails: APIRequestHeaders = .APIRequestWithNoHeader) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        switch headerDetails{
        case .APIRequestWithToken, .APIRequestWithoutToken:
            request.addValue("clientID", forHTTPHeaderField: "client-id")
            request.addValue("clientKey", forHTTPHeaderField: "client-secret")
            request.addValue("password", forHTTPHeaderField: "grant-type")
            let token = (headerDetails == .APIRequestWithToken) ? "Bearer \(accessToken)" : "Bearer kdfdfhdjfhkjsfds"
            request.setValue(token, forHTTPHeaderField: "Authorization")
           
            print("url \(url)")
            print("token \(token)")
            
        default:
            print("NO header")
        }
        
        if let headers = headers {
            for (key, value) in headers {
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        
        if let body = body {
            request.httpBody = body
        }
        return request
    }
    
    private func APIRequest<T: Decodable>(url: URL?, method: String, body: Data?, queryParameters: [String: Any]?, headers: [String: String]?, headerType: APIRequestHeaders) -> AnyPublisher<T, Error> {
       
        guard let url = url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryParameters = queryParameters {
            urlComponents?.queryItems = queryParameters.map { key, value in
                URLQueryItem(name: key, value: value as? String)
            }
        }
        
        guard let finalURL = urlComponents?.url else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        
        let request = APIURLRequest(url: finalURL, method: method, headers: headers, body: body, headerDetails: headerType)
        
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { (data, response) -> Data in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                print("Response Data \(String(decoding: data, as: UTF8.self))")
               
                if !(200...400).contains(httpResponse.statusCode) {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
    func getRequest<T: Decodable>(url: URL?, body: Data? = nil, queryParameters: [String: Any]? = nil, headers: [String: String]? = nil, headerType: APIRequestHeaders) -> AnyPublisher<T, Error> {
        return APIRequest(url: url, method: REQUEST_GET, body: body, queryParameters: queryParameters, headers: headers, headerType : headerType)
    }
    
    func postRequest<T: Decodable>(url: URL?, body: Data? = nil, queryParameters: [String: String]? = nil, headers: [String: String]? = nil, headerType: APIRequestHeaders) -> AnyPublisher<T, Error> {
        return APIRequest(url: url, method: REQUEST_POST, body: body, queryParameters: queryParameters, headers: headers, headerType : headerType)
    }
    
    func putRequest<T: Decodable>(url: URL?, body: Data? = nil, queryParameters: [String: String]? = nil, headers: [String: String]? = nil, headerType: APIRequestHeaders) -> AnyPublisher<T, Error> {
        return APIRequest(url: url, method: REQUEST_PUT, body: body, queryParameters: queryParameters, headers: headers, headerType : headerType)
    }
}

enum APIRequestHeaders{
    case APIRequestWithNoHeader, APIRequestWithoutToken, APIRequestWithToken
}
