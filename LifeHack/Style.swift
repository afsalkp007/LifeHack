//
//  Style.swift
//  LifeHack
//
//  Created by Afsal on 26/10/2024.
//

import SwiftUI

struct Style: ViewModifier {
    let color: Color
    var isFilled: Bool
    var isRounded: Bool
    
    func body(content: Content) -> some View {
        let radius = isRounded ? 10.0 : 0.0
        if isFilled {
            content
                .background(color)
                .cornerRadius(radius)
                .foregroundStyle(.white)
        } else {
            content
                .background(
                    RoundedRectangle(cornerRadius: radius)
                        .strokeBorder(color, lineWidth: 2.0)
                )
        }
    }
}

extension View {
    func style(color: Color, isFilled: Bool = true, isRounded: Bool = true) -> some View {
        modifier(Style(color: color, isFilled: isFilled, isRounded: isRounded))
    }
}

#Preview {
    let size = 100.0
    Grid {
        GridRow {
            Text("Accent")
                .frame(width: size, height: size)
                .style(color: .accentColor, isRounded: false)
            Text("Pizazz")
                .frame(width: size, height: size)
                .style(color: .pizazz)
            Text("Pizazz")
                .frame(width: size, height: size)
                .style(color: .pizazz, isFilled: false)
        }
        GridRow {
            Text("Electric Violet")
                .frame(width: size, height: size)
                .style(color: .electricViolet, isRounded: false)
            Text("Blaze Orange")
                .frame(width: size, height: size)
                .style(color: .blazeOrange)
            Text("Blaze Orange")
                .frame(width: size, height: size)
                .style(color: .blazeOrange, isFilled: false)
        }
    }
}
