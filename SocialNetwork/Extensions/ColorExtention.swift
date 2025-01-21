//
//  ColorExtention.swift
//  SocialNetwork
//
//  Created by Sergey Leschev on 24/12/22.
//

import Foundation
import UIKit
import SwiftUI

extension Color {
    
    static var themeColor: Color {
        return Color("themeColor")
    }
    
    static var lightGray: Color {
        Color(hex: "#DDDDDD")
    }
    
    init(hex: String) {
            let scanner = Scanner(string: hex.trimmingCharacters(in: .whitespacesAndNewlines))
            scanner.currentIndex = hex.hasPrefix("#") ? hex.index(after: hex.startIndex) : hex.startIndex

            var rgbValue: UInt64 = 0
            scanner.scanHexInt64(&rgbValue)

            let red = Double((rgbValue >> 16) & 0xFF) / 255.0
            let green = Double((rgbValue >> 8) & 0xFF) / 255.0
            let blue = Double(rgbValue & 0xFF) / 255.0

            self.init(red: red, green: green, blue: blue)
        }
    
}
