//
//  ImageLoader.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/4/24.
//

import SwiftUI
import Combine

class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private var cancellables = Set<AnyCancellable>()
    
    func loadImage(fromURL urlString: String) {
        if let cachedImage = ImageCache.shared.get(forKey: urlString) {
            image = cachedImage
            return
        }
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.handleImage($0, url: urlString) }
            .store(in: &cancellables)
    }
    
    private func handleImage(_ image: UIImage?, url: String) {
        guard let image = image else { return }
        ImageCache.shared.set(image, forKey: url)
        self.image = image
    }
}
