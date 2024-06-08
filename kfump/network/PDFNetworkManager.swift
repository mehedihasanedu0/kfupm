//
//  PDFNetworkManager.swift
//  kfump
//
//  Created by Mehedi Hasan on 27/5/24.
//

import Foundation
import SwiftUI
import Combine
import Photos



class PDFNetworkManager : ObservableObject {
    
    @Published var transcriptPDFData: Data?
    @Published var digitalCertificatePDFData: Data?
    @Published var pdfData: Data?
    @Published var videoData: Data?
    @AppStorage(Keys.TOKEN_D.rawValue) var accessToken: String?
    
    func downloadgenarateTranscriptPDF(courseID: Int) {
        guard let url = URL(string: URL.genarateTranscript) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["course_id": courseID]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.transcriptPDFData = data
                }
            }
        }
        task.resume()
    }    
    
    func downloadDigitalCertificatePDF(courseID: Int) {
        guard let url = URL(string: URL.genarateCertificate) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["course_id": courseID]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: [])
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.digitalCertificatePDFData = data
                }
            }
        }
        task.resume()
    }  
    
    func downloadPDF(urlString: String) {
        
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(accessToken ?? "")", forHTTPHeaderField: "Authorization")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.pdfData = data
                }
            }
        }
        task.resume()
    }
    
    func downloadVideo(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.videoData = data
                }
            } else if let error = error {
                print("Failed to download video: \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
    func downloadAndSaveVideo(from url: URL) {
        let session = URLSession.shared
        let downloadTask = session.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                print("Error downloading video: \(String(describing: error))")
                return
            }
            
            // Save the video data to a temporary file
            let tempDirectory = FileManager.default.temporaryDirectory
            let tempFileURL = tempDirectory.appendingPathComponent(UUID().uuidString).appendingPathExtension("mp4")
            
            do {
                try data.write(to: tempFileURL)
                self.saveVideoToGallery(from: tempFileURL)
            } catch {
                print("Error saving video to temporary file: \(error)")
            }
        }
        
        downloadTask.resume()
    }

    func saveVideoToGallery(from fileURL: URL) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                print("Permission to access photo library denied")
                return
            }
            
            PHPhotoLibrary.shared().performChanges({
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: fileURL)
            }) { success, error in
                if success {
                    print("Video saved to gallery successfully")
                    // Optionally, delete the temporary file after saving
                    try? FileManager.default.removeItem(at: fileURL)
                } else if let error = error {
                    print("Error saving video to gallery: \(error)")
                }
            }
        }
    }

    
}


extension PDFNetworkManager {
    
    func savePDFToFilesApp(data: Data,fileName: String, completion: @escaping (Bool) -> Void) {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(false)
            return
        }
        let fileURL = directory.appendingPathComponent("\(fileName).pdf")
        
        do {
            try data.write(to: fileURL)
            
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                if let viewController = UIApplication.shared.windows.first?.rootViewController {
                    activityViewController.popoverPresentationController?.sourceView = viewController.view
                    viewController.present(activityViewController, animated: true, completion: nil)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } catch {
            print("Error saving PDF: \(error.localizedDescription)")
            completion(false)
        }
        
    }    
    
    func saveImageToFilesApp(data: Data,fileName: String, completion: @escaping (Bool) -> Void) {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(false)
            return
        }
        let fileURL = directory.appendingPathComponent("\(fileName).png")
        
        do {
            try data.write(to: fileURL)
            
            DispatchQueue.main.async {
                let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
                if let viewController = UIApplication.shared.windows.first?.rootViewController {
                    activityViewController.popoverPresentationController?.sourceView = viewController.view
                    viewController.present(activityViewController, animated: true, completion: nil)
                    completion(true)
                } else {
                    completion(false)
                }
            }
        } catch {
            print("Error saving Image: \(error.localizedDescription)")
            completion(false)
        }
    }  
    
//    func saveVideo(data: Data, completion: @escaping (URL?) -> Void) {
//            let fileManager = FileManager.default
//            guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
//                completion(nil)
//                return
//            }
//            let fileURL = directory.appendingPathComponent("video.mp4")
//
//            do {
//                try data.write(to: fileURL)
//                completion(fileURL)
//            } catch {
//                print("Error saving video: \(error.localizedDescription)")
//                completion(nil)
//            }
//        }
    
    func saveVideo(data: Data, completion: @escaping (Bool) -> Void) {
        let fileManager = FileManager.default
        guard let directory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else {
            completion(false)
            return
        }
        let fileURL = directory.appendingPathComponent("Video.mp4")
        
        do {
            try data.write(to: fileURL)
            presentActivityViewController(fileURL: fileURL)
            completion(true)
        } catch {
            print("Error saving Video: \(error.localizedDescription)")
            completion(false)
        }
    }
    
    private func presentActivityViewController(fileURL: URL) {
        DispatchQueue.main.async {
            let activityViewController = UIActivityViewController(activityItems: [fileURL], applicationActivities: nil)
            if let viewController = UIApplication.shared.windows.first?.rootViewController {
                activityViewController.popoverPresentationController?.sourceView = viewController.view
                viewController.present(activityViewController, animated: true, completion: nil)
            }
        }
    }
}
