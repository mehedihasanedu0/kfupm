//
//  CreateBody.swift
//  kfump
//
//  Created by Mehedi Hasan on 8/4/24.
//

import Foundation
import UIKit


class CreateBody {
    
    static func createBody(with parameters: [String: Any], boundary: String) throws -> Data {

        let body = NSMutableData()

        for (key, value) in parameters {

            if(value is String || value is NSString) {
                body.appendString(string: "--\(boundary)\r\n")

                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString(string: "\(value)\r\n")
                
            }else if let image = value as? UIImage {
                let r = arc4random()
                let filename = "image\(r).jpg"
                let data = image.jpegData(compressionQuality: 0.25);
                let mimetype = "image/jpg"

                body.appendString(string: "--\(boundary)\r\n")
                body.appendString(string: "Content-Disposition: form-data; name=\"\(key)\"; filename=\"\(filename)\"\r\n")
                body.appendString(string: "Content-Type: \(mimetype)\r\n\r\n")
                body.append(data!)
                body.appendString(string: "\r\n")
            }

        }

        body.appendString(string: "--\(boundary)--\r\n")

        return body as Data

    }
    
    
}
