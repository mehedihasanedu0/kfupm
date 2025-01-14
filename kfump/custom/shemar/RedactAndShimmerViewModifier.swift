//
//  RedactAndShimmerViewModifier.swift
//  kfump
//
//  Created by Mehedi Hasan on 3/4/24.
//

import Foundation
import SwiftUI


public struct RedactAndShimmerViewModifier: ViewModifier {
  private let condition: Bool
  
  
  init(condition: Bool) {
    self.condition = condition
  }
  
  public func body(content: Content) -> some View {
    if condition {
      content
        .redacted(reason: .placeholder)
        .shimmering()
    } else {
     content
    }
  }
}


extension View {
  public func redactShimmer(condition: Bool) -> some View {
    modifier(RedactAndShimmerViewModifier(condition: condition))
  }
}
