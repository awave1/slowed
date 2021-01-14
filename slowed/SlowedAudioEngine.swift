//
//  SlowedAudioEngine.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import AudioKit
import AVFoundation
import SwiftUI

class SlowedAudioEngine: ProcessesPlayerInput {
    var player: AudioPlayer
    
    var engine: AudioEngine!;
    var reverb: Reverb!
    var playbackSpeed: VariSpeed!
    var fileUrl: URL?;
    
    init() {
        engine = AudioEngine()
        player = AudioPlayer()
        
        playbackSpeed = VariSpeed(buildEffectChain())
        playbackSpeed.rate = 0.9

        engine.output = playbackSpeed
        
        try! engine.start()
    }
    
    private func buildEffectChain() -> Node {
        reverb = Reverb(player)
        reverb.dryWetMix = 0.3
        
        return reverb
    }

    func start() {
        player.play()
        
    }
    
    func stop() {
        player.stop()
        engine.stop()
    }
    
    func load(path: URL) {
        player.stop()
        print("file loaded: \(path)")
        
        let url = path
        let file = try! AVAudioFile(forReading: url)

        player.file = file
        player.schedule(at: nil)
    }
}
