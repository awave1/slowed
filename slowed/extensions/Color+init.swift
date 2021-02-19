//
//  Color+init.swift
//  slowed
//
//  Created by awave on 2021-02-09.
//

import Foundation
import SwiftUI

func fromHex(hex: String) -> Color? {
    let red, green, blue, alpha: CGFloat
    if hex.hasPrefix("#") {
        let start = hex.index(hex.startIndex, offsetBy: 1)
        let hexColor = String(hex[start...])

        if hexColor.count == 8 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0

            if scanner.scanHexInt64(&hexNumber) {
                red = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                green = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                blue = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                alpha = CGFloat(hexNumber & 0x000000ff) / 255

                return Color.init(
                    .sRGB,
                    red: Double(red),
                    green: Double(green),
                    blue: Double(blue),
                    opacity: Double(alpha)
                )
            }
        } else if hexColor.count == 6 {
            let scanner = Scanner(string: hexColor)
            var hexNumber: UInt64 = 0
            print(hexColor)

            if scanner.scanHexInt64(&hexNumber) {
                red = CGFloat((hexNumber & 0xff0000) >> 16) / 255
                green = CGFloat((hexNumber & 0x00ff00) >> 8) / 255
                blue = CGFloat(hexNumber & 0x0000ff) / 255

                return Color.init(red: Double(red), green: Double(green), blue: Double(blue))
            }
        }
    }

    return nil
}
