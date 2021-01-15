import AudioKit
import AVFoundation
import SwiftUI

protocol ProcessesPlayerInput {
    var player: AudioPlayer { get }
    
    func load(path: URL?)
}

struct PlayerControls: View {
    var conductor: ProcessesPlayerInput
    var withSong: (() -> URL?)

    @State var isPlaying = false

    var body: some View {
        HStack {
            Button(action: togglePlay, label: {
                HStack {
                    Image(systemName: isPlaying ? "pause" : "play.fill")
                        .font(.title2)
                    
                    Text(isPlaying ? "Pause" : "Play")
                        .font(.title2)
                }
            })
            .buttonStyle(NeumorphicButtonStyle(bgColor: isPlaying ? Color.red : Color.green, cornerRadius: 40))
        }.onAppear {
            conductor.load(path: withSong())
        }
    }
    
    private func togglePlay() {
        guard self.conductor.player.file != nil else {
            print("Please load the file first")
            // TODO: show snackbar or something
            return
        }
        
        self.isPlaying ? self.conductor.player.pause() : self.conductor.player.play()
        self.isPlaying.toggle()
    }
}
