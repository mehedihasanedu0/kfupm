//
//  Websocket.swift
//  kfump
//
//  Created by Mehedi Hasan on 2/4/24.
//

import Foundation
import SwiftUI

class Websocket: ObservableObject {
    @Published var messages = [String]()
    
    private var webSocketTask: URLSessionWebSocketTask?
    
    init() {
        self.connect()
    }
    
    private func connect() {

        if let token = UserDefaults.standard.string(forKey: "accessToken") {
            print(token)
            guard let url = URL(string: "ws://app.scai.sa:8000/chat?token=\(token)") else { return }
            let request = URLRequest(url: url)
            webSocketTask = URLSession.shared.webSocketTask(with: request)
            webSocketTask?.resume()
            receiveMessage()
        }
       
    }
    
    
    
    private func receiveMessage() {
        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let message):
                switch message {
                case .string(let text):
                    print(message)
                    self.messages.append(text)
                case .data(let data):
                    // Handle binary data
                    break
                @unknown default:
                    break
                }
            }
        }
    }
    
    func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else { return }
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}
