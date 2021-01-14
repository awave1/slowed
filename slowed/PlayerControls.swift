import AudioKit
import AVFoundation
import SwiftUI

protocol ProcessesPlayerInput {
    var player: AudioPlayer { get }
}

struct PlayerControls: View {
    var conductor: ProcessesPlayerInput

    @Environment(\.colorScheme) var colorScheme
    @State var isPlaying = false

    var body: some View {
        HStack {
            Button(action: {
                self.isPlaying ? self.conductor.player.pause() : self.conductor.player.play()
                self.isPlaying.toggle()
            }, label: {
                Image(systemName: isPlaying ? "stop.fill" : "play.fill" )
            })
            .padding()
            .background(isPlaying ? Color.red : Color.green)
            .foregroundColor(.white)
            .font(.system(size: 14, weight: .semibold, design: .rounded))
            .cornerRadius(20.0)
        }
        .padding(.vertical, 15)
    }
}
