//
//  WebImageView.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/4/24.
//

import SwiftUI
import SDWebImageSwiftUI

struct WebImageView: View {
    var imageUrl = ""
    var body: some View {
        WebImage(url: URL(string: imageUrl))
            .resizable()
            .placeholder(Image("no_image_found"))
            .indicator(.activity)
            
    }
}
