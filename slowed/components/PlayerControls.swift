import AudioKit
import AVFoundation
import SwiftUI

protocol ProcessesPlayerInput {
    var player: AudioPlayer { get }
    
    func load(path: URL?)
}

struct PlayerControls: View {
    @ObservedObject var conductor: SlowedAudioEngine
    var withSong: (() -> URL?)

    @State var isPlaying = false
    @State var playbackSpeed = 0.9;

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    
                }, label: {
                    Text("Prev")
                })

                Button(action: togglePlay, label: {
                    HStack {
                        Image(systemName: isPlaying ? "pause" : "play.fill")
                            .font(.title2)
                        
                        Text(isPlaying ? "Pause" : "Play")
                            .font(.title2)
                    }
                })
                .buttonStyle(NeumorphicButtonStyle(bgColor: isPlaying ? Color.red : Color.green, cornerRadius: 40))
                
                Button(action: {}, label: {
                    Text("Next")
                })
            }.padding()

            
            
            
            VStack {
                HStack {
                    Text("Playback Speed")
                    Slider(value: $conductor.data.playbackSpeed, in: 0.5...1, step: 0.1, minimumValueLabel: Text("0.5"), maximumValueLabel: Text("1")) {
                        EmptyView()
                    }.padding()
                }
                
                HStack {
                    Text("Reverb")
                    Slider(value: $conductor.data.reverbDryWetMix, in: 0...1, minimumValueLabel: Text("Dry"), maximumValueLabel: Text("Wet")) {
                        EmptyView()
                    }.padding()
                }
            }.padding()
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
