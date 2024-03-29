//
//  CustomScrollView.swift
//  scai_ios
//
//  Created by Mehedi Hasan on 7/1/24.
//

import SwiftUI
import UIKit

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = [CGFloat]
    static var defaultValue: [CGFloat] = []

    static func reduce(value: inout [CGFloat], nextValue: () -> [CGFloat]) {
        value.append(contentsOf: nextValue())
    }
}
