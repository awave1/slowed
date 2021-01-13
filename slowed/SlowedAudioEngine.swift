//
//  SlowedAudioEngine.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import AudioKit
import AVFoundation

class SlowedAudioEngine {
    var engine: AudioEngine!;
    var player: AudioPlayer!
    var reverb: Reverb!
    var playbackSpeed: VariSpeed!
    var audioFile: AVAudioFile!;
    
    init(filename: String) {
        engine = AudioEngine()
        
        do {
            audioFile = try AVAudioFile(forReading: URL(fileURLWithPath: filename))
        } catch {
            print("Failed to load \(filename)")
            return
        }
        
        player = AudioPlayer(file: audioFile)
        
        playbackSpeed = VariSpeed(buildEffectChain())
        playbackSpeed.rate = 0.9
    
        engine.output = playbackSpeed
        do {
            try engine.start()
        } catch{
            print("Failed to start AKManager")
        }
    }
    
    private func buildEffectChain() -> Node {
        reverb = Reverb(player)
        reverb.dryWetMix = 0.3
        
        return reverb
    }
}
