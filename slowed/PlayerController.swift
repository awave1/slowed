//
//  PlayerController.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-27.
//

import Foundation
import SwiftUI

class PlayerController: ObservableObject {
    @Published var files: [URL]
    @Published var currentSelection: Int? = 0
    @Published var currentSong: URL?

    static var instance: PlayerController = PlayerController()

    private init() {
        self.files = []
    }

    func appendFile(link: URL) {
        files.append(link)
    }

    func getNext(_ index: Int) -> Int {
        if index == (files.count - 1) {
            return index
        }

        return index + 1
    }

    func getPrev(_ index: Int) -> Int {
        if index == 0 {
            return 0
        }

        return index - 1
    }
}
