//
//  ImageCache.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/4/24.
//

import SwiftUI

struct ImageCache {
    
    static let shared = ImageCache()
    private var cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func get(forKey key: String) -> UIImage? {
        return cache.object(forKey: NSString(string: key))
    }
    
    func set(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
