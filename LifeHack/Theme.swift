//
//  Theme.swift
//  LifeHack
//
//  Created by Afsal on 29/10/2024.
//

import SwiftUI

struct Theme: Identifiable, Hashable {
    let name: String
    let accentColor: Color
    let secondaryColor: Color
    
    var id: String { name }
    
    static let `default` = Theme(
        name: "Default",
        accentColor: .accent,
        secondaryColor: .pizazz)
    
    static let vibrant = Theme(
        name: "Vibrant",
        accentColor: .electricViolet,
        secondaryColor: .blazeOrange)
    
    static let allThemes: [Theme] = [.default, .vibrant]
}
