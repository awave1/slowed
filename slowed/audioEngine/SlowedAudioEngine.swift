//
//  SlowedAudioEngine.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import AudioKit
import AVFoundation
import SwiftUI

struct SlowedAudioEngineData{
    var playbackSpeed: AUValue = 0.9
    var reverbDryWetMix: AUValue = 0.3
}

class SlowedAudioEngine: ObservableObject, ProcessesPlayerInput {
    var player: AudioPlayer
    
    var engine: AudioEngine!;
    var reverb: Reverb!
    var playbackSpeed: VariSpeed!
    var fileUrl: URL?;
    
    init() {
        engine = AudioEngine()
        player = AudioPlayer()
        
        playbackSpeed = VariSpeed(buildEffectChain())
        playbackSpeed.rate = data.playbackSpeed

        engine.output = playbackSpeed
        
        startEngine()
    }
    
    private func buildEffectChain() -> Node {
        reverb = Reverb(player)
        reverb.dryWetMix = data.reverbDryWetMix
        
        return reverb
    }
    
    private func startEngine() {
        do {
            try engine.start()
        } catch {
            print("Failed to start engine: \(error)")
        }
    }

    func start() {
        player.play()
    }
    
    func stop() {
        player.stop()
        engine.stop()
    }
    
    func load(path: URL?) {
        if let path = path {
            print("loading: \(path)")
            player.stop()
            
            let url = path
            let file = try! AVAudioFile(forReading: url)

            player.file = file
            player.schedule(at: nil)
        } else {
            print("path is nil")
        }
    }
    
    @Published var data = SlowedAudioEngineData() {
        didSet {
            playbackSpeed.rate = data.playbackSpeed
            reverb.dryWetMix = data.reverbDryWetMix
        }
    }
}
