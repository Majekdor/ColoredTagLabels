//
//  UIColor+ContrastRatio.swift
//  ColoredTagLabels
//
//  Created by Kevin Barnes on 12/9/25.
//

import UIKit

extension UIColor {
    
    /// sRGB relative luminance per WCAG
    private var relativeLuminance: CGFloat {
        func adjust(_ c: CGFloat) -> CGFloat {
            c <= 0.03928
              ? c / 12.92
              : pow((c + 0.055) / 1.055, 2.4)
        }
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        getRed(&r, green:&g, blue:&b, alpha:&a)
        return 0.2126*adjust(r)
             + 0.7152*adjust(g)
             + 0.0722*adjust(b)
    }

    /// Contrast ratio between two colors per WCAG
    func contrastRatio(with other: UIColor) -> CGFloat {
        let L1 = max(relativeLuminance, other.relativeLuminance)
        let L2 = min(relativeLuminance, other.relativeLuminance)
        return (L1 + 0.05) / (L2 + 0.05)
    }
}
