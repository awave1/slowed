//
//  utils.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-27.
//

import Foundation
import AudioKit
import AVFoundation
import MediaPlayer

func getSongName(path: URL) -> String {
    let item = AVPlayerItem(url: path)
    let metadata = item.asset.metadata
    var artist = ""
    var title = ""

    for item in metadata {
        switch item.commonKey {
        case .commonKeyTitle?:
            title = item.stringValue ?? ""
        case .commonKeyArtist?:
            artist = item.stringValue ?? ""
        case .none:
            break
        default:
            break
        }
    }

    if artist.isEmpty && title.isEmpty {
        return path.lastPathComponent
    } else {
        return "\(artist) - \(title)"
    }
}
