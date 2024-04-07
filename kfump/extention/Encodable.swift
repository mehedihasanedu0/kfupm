//
//  Encodable.swift
//  kfump
//
//  Created by Mehedi Hasan on 7/4/24.
//

import Foundation
import SwiftUI


extension Encodable {
    func toJsonData() throws -> Data {
        let encoder = JSONEncoder()
        return try encoder.encode(self)
    }
    
    func asDictionary() throws -> [String: Any] {
        let data = try JSONEncoder().encode(self)
        guard let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            throw NSError()
        }
        return dictionary
    }
}
