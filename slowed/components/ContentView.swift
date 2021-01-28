//
//  ContentView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI

struct ContentView: View {
    @State var pathToFile: URL?
    @State var selection: Int? = 0

    @ObservedObject var conductor = SlowedAudioEngine()
    @ObservedObject var playerController = PlayerController.instance
    
    var body: some View {
        VStack {
            NavigationView {
                List {
                    ForEach((0..<playerController.files.count), id: \.self) { index in
                        let file = playerController.files[index]
                        NavigationLink(
                            destination: PlayView(
                                pathToFile: file,
                                conductor: conductor,
                                index: index,
                                selection: $selection
                            ),
                            tag: index,
                            selection: $selection
                        ) {
                            Text(getSongName(path: file))
                                .padding(.vertical, 2.0)
                        }
                    }

                    ChooseFileButton(onSelected: { url in
                        DispatchQueue.main.async {
                            self.playerController.appendFile(link: url)
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
        ContentView()
    }
}
