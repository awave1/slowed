//
//  ContentView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI

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
