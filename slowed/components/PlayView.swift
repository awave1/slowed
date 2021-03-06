//
//  PlayView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-27.
//

import Foundation
import SwiftUI
import AudioKit
import AVFoundation
import MediaPlayer

struct PlayView: View {
    @State var pathToFile: URL?

    var index: Int = 0
    @Binding var selection: Int?

    var body: some View {
        VStack {
            PlayerControls(
                songPath: $pathToFile,
                selection: $selection,
                index: index
            )
        }
        .padding()
    }
}
