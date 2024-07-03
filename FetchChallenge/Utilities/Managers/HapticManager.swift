//
//  HapticManager.swift
//  FetchChallenge
//
//  Created by Daniel Berezhnoy on 7/3/24.
//

import SwiftUI
import CoreHaptics

struct HapticManager {
    /// Plays haptic feedback
    static func playImpact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}
