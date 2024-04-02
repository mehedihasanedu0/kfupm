//
//  CustomImage.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/4/24.
//

import Foundation
import SwiftUI

struct CustomImage: View {
    @StateObject private var loader = ImageLoader()
    let urlString: String
    
    var body: some View {
        Group {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
            } else {
                ProgressView()
            }
        }
        .onAppear { loader.loadImage(fromURL: urlString) }
    }
}
