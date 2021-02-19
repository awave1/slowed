//
//  NeuorphicButtonStyle.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-14.
//

import Foundation
import SwiftUI

struct NeumorphicButtonStyle: ButtonStyle {
    var bgColor: Color
    var cornerRadius: CGFloat = 20
    var circle = false

    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .padding(20)
            .background(
                ZStack {
                    if !circle {
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .shadow(
                                color: .white,
                                radius: configuration.isPressed ? 7: 10,
                                x: configuration.isPressed ? -5: 0,
                                y: configuration.isPressed ? -5: 0
                            )
                            .shadow(
                                color: .black,
                                radius: configuration.isPressed ? 7: 10,
                                x: configuration.isPressed ? 5: 0,
                                y: configuration.isPressed ? 5: 0
                            )
                            .blendMode(.overlay)
                        RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                            .fill(bgColor)
                    } else {
                        Circle()
                            .shadow(
                                color: .white,
                                radius: configuration.isPressed ? 7 : 10,
                                x: configuration.isPressed ? -5: 0,
                                y: configuration.isPressed ? -5: 0
                            )
                            .shadow(
                                color: .black,
                                radius: configuration.isPressed ? 7: 10,
                                x: configuration.isPressed ? 5: 0,
                                y: configuration.isPressed ? 5: 0
                            )
                            .blendMode(.overlay)
                        Circle()
                            .fill(bgColor)
                    }
                }
        )
            .scaleEffect(configuration.isPressed ? 0.95: 1)
            .foregroundColor(.primary)
            .animation(.spring())
    }
}
