//
//  NetworkClientForMultipart.swift
//  kfump
//
//  Created by Mehedi Hasan on 24/4/24.
//

import Foundation
import SwiftUI
import Combine

class NetworkClientForMultipart {
    
    static let shared = NetworkClientForMultipart()
    @AppStorage(IS_LOGIN_D) var isLogin: Bool = false
    @AppStorage(TOKEN_D) var accessToken: String?
    
    
    func postMultipartData(url: URL, parameter: [String: Any]? = nil, httpMethod: String, completion:@escaping(HandlerResult)->Void) {
       let task = URLSession.shared.dataTask(with: (createRequestWithMultipleImage(url: url, parameter: parameter, httpMethod: httpMethod) as NSMutableURLRequest) as URLRequest)  {
           (data, response, error) in
           
           guard let data = data, error == nil else {
               completion(.failure(NetworkError.offline))
               return
           }
           
           
           if let statusCode = response?.getStatusCode(){
               
               if let status = HTTPStatusCodes.init(rawValue: statusCode) {
                   print("statusCode of \(url): ",statusCode)
                   do {
                       
                       if let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                           print("json data: \(json)")
                       }
                   }
                   catch let error {
                       print(error)
                   }
                   
                   completion(.success(data, status))
               }
           }
       }
       
       task.resume()
       
   }
    
    
    func createRequestWithMultipleImage(url: URL, parameter: [String: Any]?, httpMethod: String) -> NSMutableURLRequest {
        
        let request = NSMutableURLRequest(url:url as URL);
        request.httpMethod = httpMethod
        
        request.addValue("Bearer \(self.accessToken ?? "")", forHTTPHeaderField: "Authorization")
        
        let boundary = generateBoundaryString()
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
//        if let authorizationToken = GlobalVariable.shared.getJwt() {
//            request.setValue(accessToken ?? "", forHTTPHeaderField: "Authorization")
//        }
//        
        if let parameter = parameter {
            request.httpBody = try? createBody(with: parameter, boundary: boundary)
            
        }
        
        if let json = try? JSONSerialization.jsonObject(with: request.httpBody!, options: .allowFragments) as? [String: Any] {
            print("json data: \(json)")
        }
        
        return request
    }
    
    func createBody(with parameters: [String: Any], boundary: String) throws -> Data {
        
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
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
}
