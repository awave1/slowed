//
//  ContentView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI
import AudioKit
import AVFoundation

var listItems = ["Item 1", "Item 2", "Item 3", "Item 4"]

struct PlayView: View {
    @State var pathToFile: URL?
//    var pathToFile: URL?
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
                
//                ChooseFileButton(onSelected: { url in
//                    pathToFile = url
//                    conductor.load(path: url)
//                })
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
                        }.frame(width: .infinity)
                    }
                    
                    ChooseFileButton(onSelected: { url in
                        DispatchQueue.main.async {
                            links.append(url)
                        }
                    })
                    Spacer()
                    
                }
                .frame(width: 200)
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
