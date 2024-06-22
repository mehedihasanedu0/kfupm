//
//  SingleChat.swift
//  kfump
//
//  Created by Mehedi Hasan on 21/6/24.
//

import SwiftUI
import SocketIO

struct Message: Hashable {
    var username: String
    var text: String
    var id: UUID
}


// Define a delegate protocol
protocol ChatDelegate {
    func gotMessage(item: MessageResponse)
}


class ChatClient: NSObject , URLSessionWebSocketDelegate {
    
    static let shared = ChatClient()
    @AppStorage(Keys.refreshToken.rawValue) var refreshToken: String?

//    var manager: SocketManager!
//    var socket: SocketIOClient!
    var username: String!
    var delegate: ChatDelegate? = nil
    
    private var webSocketTask: URLSessionWebSocketTask?


    override init() {
        super.init()
        
        print(refreshToken ?? "")
        guard let url = URL(string: "wss://kfu-dev-admin.ewnbd.com/ws/chat/?token=\(refreshToken ?? "")") else { return }
        let request = URLRequest(url: url)
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: OperationQueue())

        webSocketTask = session.webSocketTask(with: request)
        
        webSocketTask?.resume()
        receiveMessage()
//        if let token = refreshToken ?? "" {
//
//            
//        }
//        manager = SocketManager(socketURL: URL(string: "https://app.scai.sa/chat?token=\(UserDefaults.standard.string(forKey: "accessToken")!)")!)
//        socket = manager.defaultSocket
        
    }
//
    func connect() {
        if let token = UserDefaults.standard.string(forKey: "accessToken") {
            print(token)
            guard let url = URL(string: "wss://kfu-dev-admin.ewnbd.com/ws/chat/?token=\(token)") else { return }
            let request = URLRequest(url: url)
            webSocketTask = URLSession.shared.webSocketTask(with: request)
            webSocketTask?.resume()
            receiveMessage()
        }
    }

    func disconnect() {
       // webSocketTask.disconnect()
    }

    func sendMessage(_ message: String) {
        guard let data = message.data(using: .utf8) else { return }
        webSocketTask?.send(.string(message)) { error in
            if let error = error {
                self.connect()
                print(error.localizedDescription)
            }
        }
//        socket.emit("sendMessage", message)
    }

    func sendUsername(_ username: String) {
//        socket.emit("sendUsername", username)
    }

    func receiveMessage() {
        //func receiveMessage(_ completion: @escaping (MessageResponse) -> Void) {

        webSocketTask?.receive { result in
            switch result {
            case .failure(let error):
                print("WebSocket task failed with error: \(error)")
                print(error.localizedDescription)
                self.connect()
                
            case .success(let message):
                switch message {
                case .string(let text):
//                    print(message)
//                    print(text)

//                    completion("demo", text, UUID())
//                    self.messages.append(text)
                    if let jsonData = text.data(using: .utf8) {
                        do {
                            // Deserialize the JSON data into a JSON object (NSDictionary or NSArray)
                            let messageResponse = try JSONDecoder().decode(MessageResponse.self, from: jsonData)
                            DispatchQueue.main.async {
                                self.delegate?.gotMessage(item: messageResponse)
                            }
                            
                           // completion(messageResponse)
                            

                          
                        } catch {
                            print("Error converting string to JSON: \(error.localizedDescription)")
                        }
                    }
                    self.receiveMessage()
                case .data(let data):
                    // Handle binary data
                    print("data called")
                    break
                @unknown default:
                    break
                }
            }
        }
        
    }
    
    func urlSession(_ session: URLSession, webSocketTask: URLSessionWebSocketTask, didCloseWith closeCode: URLSessionWebSocketTask.CloseCode, reason: Data?) {
            print("WebSocket did close with code: \(closeCode)")
            // Perform actions on WebSocket close
        }

    func receiveNewUser(_ completion: @escaping (String, [String:String]) -> Void) {
//        socket.on("receiveNewUser") { data, _ in
//            if let username = data[0] as? String,
//               let users = data[1] as? [String:String] {
//                completion(username, users)
//            }
//        }
    }
}


struct SendMessageModel {
    let message: String
    let receiver: Int
}



struct MessageResponse: Codable {
    let type: String
    let chatRoomID, receiverID, id: Int
    let user1, user2: ChatUser
    let lastMessage, lastMessageAt: String
    let user1Seen, user2Seen: Bool

    enum CodingKeys: String, CodingKey {
        case type
        case chatRoomID = "chat_room_id"
        case receiverID = "receiver_id"
        case id, user1, user2
        case lastMessage = "last_message"
        case lastMessageAt = "last_message_at"
        case user1Seen = "user1_seen"
        case user2Seen = "user2_seen"
    }
}

// MARK: - User
struct ChatUser: Codable {
    let id: Int
    let displayName: String
    let profilePicture: String?

    enum CodingKeys: String, CodingKey {
        case id, displayName
        case profilePicture = "profile_picture"
    }
}
