//
//  AppState.swift
//  slowed
//
//  Created by Artem Golovin on 2021-02-19.
//

import Foundation
import Combine

class AppState: ObservableObject {
    @Published var songs: [URL]
    @Published var slowedAudioEngine: SlowedAudioEngine
    @Published var playerController: PlayerController

    @Published var currentSelection: Int? = 0
    @Published var currentSong: URL?
    @Published var isPlaying = false
    @Published var displayControls = false

    init() {
        self.songs = []
        self.slowedAudioEngine = SlowedAudioEngine()
        self.playerController = PlayerController.instance
    }

    func addSong(_ url: URL) {
        self.songs.append(url)
    }

    func getSongCount() -> Int {
        return self.songs.count
    }
}
