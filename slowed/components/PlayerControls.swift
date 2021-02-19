import AudioKit
import AVFoundation
import SwiftUI

protocol ProcessesPlayerInput {
    var player: AudioPlayer { get }

    func load(path: URL?)
}

struct PlayerControls: View {
    @State var isPlaying = false
    @State var playbackSpeed = 0.9

    @Binding var songPath: URL?
    @Binding var selection: Int?
    var index: Int = 0
    @Binding var displayControls: Bool

    @ObservedObject var playerController = PlayerController.instance
    @ObservedObject var conductor = SlowedAudioEngine.instance

    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    selection = playerController.getPrev(index)
                    play()
                }, label: {
                    Image(systemName: index == 0 ? "backward" : "backward.fill")
                        .font(.title2)
                })
                .disabled(index == 0)
                .buttonStyle(
                    NeumorphicButtonStyle(
                        bgColor: Color.init(CGColor.init(red: 0, green: 0, blue: 0, alpha: 0)),
                        circle: true
                    )
                )

                Button(action: togglePlay, label: {
                    Image(systemName: isPlaying ? "pause" : "play.fill")
                        .font(.title2)
                })
                .buttonStyle(
                    NeumorphicButtonStyle(bgColor: isPlaying ? Color.red : Color.green, circle: true)
                )

                Button(action: {
                    selection = playerController.getNext(index)
                    play()
                }, label: {
                    Image(systemName: index == self.playerController.files.count - 1 ? "forward" : "forward.fill")
                        .font(.title2)
                })
                .disabled(index == self.playerController.files.count - 1)
                .buttonStyle(
                    NeumorphicButtonStyle(
                        bgColor: Color.init(CGColor.init(red: 0, green: 0, blue: 0, alpha: 0)),
                        circle: true
                    )
                )
            }.padding()

            if self.displayControls {
                VStack {
                    HStack {
                        Text("Playback Speed")
                        Slider(
                            value: $conductor.data.playbackSpeed,
                            in: 0.5...1, step: 0.1,
                            minimumValueLabel: Text("0.5"),
                            maximumValueLabel: Text("1")
                        ) {
                            EmptyView()
                        }.padding()
                    }

                    HStack {
                        Text("Reverb")
                        Slider(
                            value: $conductor.data.reverbDryWetMix,
                            in: 0...1,
                            minimumValueLabel: Text("Dry"),
                            maximumValueLabel: Text("Wet")
                        ) {
                            EmptyView()
                        }.padding()
                    }
                }.padding()
            }
        }
    }

    private func togglePlay() {
        if !self.isPlaying {
            conductor.load(path: self.playerController.files[selection ?? 0])
        }

        guard self.conductor.player.file != nil else {
            print("Please load a file first")
            return
        }

        self.isPlaying ? self.conductor.player.pause() : self.conductor.player.play()
        self.isPlaying.toggle()
    }

    private func play() {
        if selection != nil && self.isPlaying {
            conductor.load(path: self.playerController.files[selection!])
            self.conductor.player.play()
            self.isPlaying = true
        }
    }
}
