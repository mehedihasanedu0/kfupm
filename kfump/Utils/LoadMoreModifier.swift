//
//  LoadMoreModifier.swift
//  scai_ios
//
//  Created by Mehedi Hasan on 7/1/24.
//

import Foundation
import SwiftUI

struct LoadMoreModifier: ViewModifier {
    let threshold: CGFloat
    let onReached: () -> Void

    func body(content: Content) -> some View {
        content
            .onAppear(perform: checkIfNearBottom)
    }

    private func checkIfNearBottom() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            let currentOffsetY = UIScrollView.appearance().contentOffset.y
            let contentHeight = UIScrollView.appearance().contentSize.height
            let frameHeight = UIScrollView.appearance().frame.size.height

            let distanceToBottom = contentHeight - currentOffsetY
            if distanceToBottom < (frameHeight * threshold) {
                onReached()
            }
        }
    }
}

extension View {
    func onLoadMore(threshold: CGFloat = 0.9, perform action: @escaping () -> Void) -> some View {
        self.modifier(LoadMoreModifier(threshold: threshold, onReached: action))
    }
}
