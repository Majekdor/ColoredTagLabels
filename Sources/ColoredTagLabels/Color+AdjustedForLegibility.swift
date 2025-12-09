//
//  Color+AdjustedForLegibility.swift
//  ColoredTagLabels
//
//  Created by Kevin Barnes on 12/9/25.
//

import SwiftUI

extension Color {
    
    /// Ensures at least a 4.5:1 contrast against white (Light Mode)
    /// or black (Dark Mode), by iteratively tweaking brightness.
    func adjustedForLegibility() -> Color {
        let kMinContrast: CGFloat = 4.5
        let kStep: CGFloat = 0.1  // brightness adjustment granularity
        
        let base = UIColor(self)
        
        let dynamic = UIColor { traits in
            // 1) pick background
            let bg = (traits.userInterfaceStyle == .dark)
                   ? UIColor.black
                   : UIColor.white
            
            // 2) if contrast is already OK, just return
            guard base.contrastRatio(with: bg) < kMinContrast else {
                return base
            }
            
            // 3) decompose HSB
            var h: CGFloat = 0, s: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
            base.getHue(&h, saturation:&s, brightness:&b, alpha:&a)
            
            // 4) walk brightness until contrast ≥ kMinContrast
            if traits.userInterfaceStyle == .dark {
                var newB = b
                while newB <= 1 {
                    let candidate = UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
                    if candidate.contrastRatio(with: bg) >= kMinContrast { break }
                    newB += kStep
                }
                b = min(newB, 1)
            } else {
                var newB = b
                while newB >= 0 {
                    let candidate = UIColor(hue: h, saturation: s, brightness: newB, alpha: a)
                    if candidate.contrastRatio(with: bg) >= kMinContrast { break }
                    newB -= kStep
                }
                b = max(newB, 0)
            }
            
            return UIColor(hue: h, saturation: s, brightness: b, alpha: a)
        }
        
        return Color(dynamic)
    }
}
