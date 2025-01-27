//
//  Observation.swift
//  ObservationUIKit
//
//  Created by Ptera on 1/23/25.
//

import Foundation
import Perception
import UIKit

@MainActor
func observe(apply: @escaping @MainActor @Sendable () -> Void) {
    onChange(apply: apply)
}

@MainActor
func onChange(apply: @escaping @MainActor @Sendable () -> Void) {
    withPerceptionTracking {
        apply()
    } onChange: {
        Task { @MainActor in
          if let animation = UIAnimation.current {
            UIView.animate(withDuration: animation.duration) {
              onChange(apply: apply)
            }
          } else {
            onChange(apply: apply)
          }
        }
    }
}

extension NSObject {
    @MainActor
    func observe(apply: @escaping @MainActor @Sendable () -> Void) {
        ObservationUIKit.observe(apply: apply)
    }
}

struct UIAnimation: Sendable {
    @TaskLocal fileprivate static var current: Self?
    var duration: TimeInterval
}

@MainActor
func withUIAnimation(_ animation: UIAnimation? = UIAnimation(duration: 0.3), body: @escaping () -> Void) {
    guard let animation else {
        body()
        return
    }
    
    UIAnimation.$current.withValue(animation) {
        body()
    }
}



