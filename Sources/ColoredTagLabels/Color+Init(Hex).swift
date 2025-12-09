//
//  Color+Init(Hex).swift
//  ColoredTagLabels
//
//  Created by Kevin Barnes on 12/9/25.
//

import SwiftUI

extension Color {
    
    init(hex: String) {
        var cleanHexCode = hex.trimmingCharacters(in: .whitespacesAndNewlines)
        cleanHexCode = cleanHexCode.replacingOccurrences(of: "#", with: "")
        var rgb: UInt64 = 0
        
        Scanner(string: cleanHexCode).scanHexInt64(&rgb)
        
        let redValue = Double((rgb >> 16) & 0xFF) / 255.0
        let greenValue = Double((rgb >> 08) & 0xFF) / 255.0
        let blueValue = Double((rgb >> 00) & 0xFF) / 255.0
        self.init(red: redValue, green: greenValue, blue: blueValue)
    }
}
