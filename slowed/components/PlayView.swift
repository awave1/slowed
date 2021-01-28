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
    @ObservedObject var conductor: SlowedAudioEngine
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: nil) {
                VStack {
                    if let pathToFile = pathToFile {
                        Text(getSongName(path: pathToFile))
                            .font(.title)
                    }
                }
            }
            
            PlayerControls(conductor: conductor, withSong: {
                return pathToFile
            })
        }
        .padding()
    }
}

struct PlayView_preview: PreviewProvider {
    static var previews: some View {
        PlayView(pathToFile: nil, conductor: SlowedAudioEngine())
    }
}
