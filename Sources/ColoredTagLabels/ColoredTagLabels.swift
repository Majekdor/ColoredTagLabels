//
//  ColoredTagLabels.swift
//  ColoredTagLabels
//
//  Created by Kevin Barnes on 12/9/25.
//

import SwiftUI

public struct ColoredTagLabel: View {
    
    @Environment(\.colorScheme) private var colorScheme
    
    let label: String
    let color: String?
    var sfSymbol: String?
    
    public init(
        label: String,
        color: String?,
        sfSymbol: String? = nil
    ) {
        self.label = label
        self.color = color
        self.sfSymbol = sfSymbol
    }
    
    public var body: some View {
        if #available(iOS 26.0, *) {
            tagLabel
                .glassEffect(.regular.tint(backgroundColor).interactive(), in: .capsule)
        } else {
            tagLabel
                .background(
                    (color == nil ? Color.secondary : Color(hex: color!))
                        .opacity(colorScheme == .light ? 0.15 : 0.4)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 50)
                        .stroke(color == nil ? Color.secondary : Color(hex: color!), lineWidth: 3.0)
                }
                .cornerRadius(50)
        }
    }
    
    private var tagLabel: some View {
        HStack {
            if let sfSymbol {
                Image(systemName: sfSymbol)
                    .font(.footnote)
            }
            
            Text(label)
                .font(.callout)
        }
        .foregroundStyle(foregroundColor)
        .padding(.all, 6)
        .padding(.horizontal, 4)
    }
    
    private var foregroundColor: Color {
        if let color {
            return Color(hex: color).adjustedForLegibility()
        }
        
        return .primary
    }
    
    private var backgroundColor: Color {
        if let color {
            return Color(hex: color).opacity(0.15)
        }
        
        return colorScheme == .dark ? Color(uiColor: .systemGray5).opacity(0.15) : .white.opacity(0.15)
    }
}

#Preview {
    VStack(spacing: 20) {
        ColoredTagLabel(
            label: "Five Stars",
            color: "#80EF80",
            sfSymbol: "star.fill"
        )
        
        ColoredTagLabel(
            label: "McLaren",
            color: "#FF8000"
        )
        
        ColoredTagLabel(
            label: "Carolina",
            color: "#4B9CD3"
        )
        
        ColoredTagLabel(
            label: "Light Mode",
            color: nil
        )
        .environment(\.colorScheme, .light)
        
        ColoredTagLabel(
            label: "Dark Mode",
            color: nil
        )
        .environment(\.colorScheme, .dark)
    }
}
