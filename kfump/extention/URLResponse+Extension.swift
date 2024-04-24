//
//  URLResponse+Extension.swift
//  kfump
//
//  Created by Mehedi Hasan on 24/4/24.
//

import Foundation

extension URLResponse {

    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}
