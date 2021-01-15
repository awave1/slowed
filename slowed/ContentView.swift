//
//  ContentView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI
import AudioKit
import AVFoundation

struct PlayView: View {
    @State var pathToFile: URL?
    var conductor: SlowedAudioEngine

    var body: some View {
        VStack {
            VStack(alignment: .center, spacing: nil) {
                VStack {
                    if pathToFile != nil {
                        Text(pathToFile!.absoluteString)
                            .font(.title)
                    } else {
                        Text("Choose a song")
                            .font(.title)
                            .bold()
                            .italic()
                            .textCase(.uppercase)
                    }
                }
            }
            
            PlayerControls(conductor: conductor, withSong: {
                return pathToFile
            })
        }
        .frame(minWidth: 700, minHeight: 300)
        .padding()
    }
}

struct ContentView: View {
    @State var pathToFile: URL?
    @State var links: [URL]
    var conductor = SlowedAudioEngine()
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach((0..<links.count), id: \.self) { index in
                        NavigationLink(
                            destination: PlayView(pathToFile: links[index], conductor: conductor)
                        ) {
                            Text(links[index].absoluteString)
                                .padding(.vertical, 2.0)
                        }
                    }
                    
                    ChooseFileButton(onSelected: { url in
                        DispatchQueue.main.async {
                            links.append(url)
                        }
                    })
                    Spacer()
                    
                }
                .frame(minWidth: 200, maxWidth: 500)
                .listStyle(SidebarListStyle())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(links: [])
    }
}
