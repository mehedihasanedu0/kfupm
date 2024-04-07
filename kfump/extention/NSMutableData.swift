//
//  NSMutableData.swift
//  kfump
//
//  Created by Mehedi Hasan on 8/4/24.
//

import Foundation

extension NSMutableData {
    func appendString(string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: true)
        append(data!)
    }
}
