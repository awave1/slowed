import AudioKit
import AVFoundation
import SwiftUI

protocol ProcessesPlayerInput {
    var player: AudioPlayer { get }

    func load(path: URL?)
}

struct PlayerControls: View {
    @State var playbackSpeed = 0.9

    @Binding var songPath: URL?
    @Binding var selection: Int?
    var index: Int = 0

    @EnvironmentObject var state: AppState

    var body: some View {
        VStack {

            ZStack {
                if state.isPlaying {
                    DryWetMixPlotsView(mix: state.slowedAudioEngine.mixPlot)
                        .transition(.move(edge: .trailing))
                }

                VStack(alignment: .center, spacing: nil) {
                    VStack {
                        if let songPath = songPath {
                            Text(getSongName(path: songPath))
                                .font(.title)
                        }
                    }

                    HStack {
                        Button(action: {
                            selection = state.playerController.getPrev(index)
                            play()
                        }, label: {
                            Image(systemName: index == 0 ? "backward" : "backward.fill")
                                .font(.title2)
                                .foregroundColor(.white)
                        })
                        .disabled(index == 0)
                        .buttonStyle(
                            NeumorphicButtonStyle(
                                bgColor: Color.white.opacity(0.0),
                                circle: true
                            )
                        )

                        Button(action: togglePlay, label: {
                            Image(systemName: state.isPlaying ? "pause" : "play.fill")
                                .font(.title2)
                        })
                        .buttonStyle(
                            NeumorphicButtonStyle(bgColor: state.isPlaying ? Color.red : Color.green, circle: true)
                        )

                        Button(action: {
                            selection = state.playerController.getNext(index)
                            play()
                        }, label: {
                            Image(systemName: index == state.getSongCount() - 1 ? "forward" : "forward.fill")
                                .font(.title2)
                                .foregroundColor(.white)

                        })
                        .disabled(index == state.getSongCount() - 1)
                        .buttonStyle(
                            NeumorphicButtonStyle(
                                bgColor: Color.white.opacity(0.0),
                                circle: true
                            )
                        )
                    }.padding()
                }
            }

            if state.displayControls {
                VStack {
                    HStack {
                        Text("Playback Speed")
                        Slider(
                            value: $state.slowedAudioEngine.data.playbackSpeed,
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
                            value: $state.slowedAudioEngine.data.reverbDryWetMix,
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
        if !state.isPlaying {
            state.slowedAudioEngine.load(path: state.songs[selection ?? 0])
        }

        guard state.slowedAudioEngine.player.file != nil else {
            print("Please load a file first")
            return
        }

        if state.isPlaying {
            state.slowedAudioEngine.player.pause()
        } else {
            state.slowedAudioEngine.player.play()
        }

        state.isPlaying.toggle()
    }

    private func play() {
        if selection != nil && state.isPlaying {
            state.slowedAudioEngine.load(path: self.state.songs[selection!])
            state.slowedAudioEngine.player.play()
            state.isPlaying = true
        }
    }
}
