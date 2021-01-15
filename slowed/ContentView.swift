//
//  ContentView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI
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
    
    if (artist.isEmpty && title.isEmpty) {
        return path.absoluteString
    } else {
        return "\(artist) - \(title)"
    }
}

struct PlayView: View {
    @State var pathToFile: URL?
    @ObservedObject var conductor: SlowedAudioEngine
    
    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: nil) {
                VStack {
                    if let pathToFile = pathToFile {
                        Text(getSongName(path: pathToFile))
                            .font(.title)
                    }
                }
            }
            
            PlayerControls(conductor: conductor, withSong: {
                return pathToFile
            })
        }
        .padding()
    }
}

struct ContentView: View {
    @State var pathToFile: URL?
    @State var links: [URL]
    @ObservedObject var conductor = SlowedAudioEngine()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach((0..<links.count), id: \.self) { index in
                        NavigationLink(
                            destination: PlayView(pathToFile: links[index], conductor: conductor)
                        ) {
                            Text(getSongName(path: links[index]))
                                .padding(.vertical, 2.0)
                        }
                    }
                    
                    Spacer()
                    ChooseFileButton(onSelected: { url in
                        DispatchQueue.main.async {
                            links.append(url)
                        }
                    })
                    Spacer()
                }
                .frame(minWidth: 180, idealWidth: 200, maxWidth: 300)
                .listStyle(SidebarListStyle())
            }
        }
        .frame(minWidth: 700, minHeight: 300)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(links: [])
    }
}
