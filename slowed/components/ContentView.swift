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

    @ObservedObject var playerController = PlayerController.instance
    
    var body: some View {
        NavigationView {
            List {
                ForEach((0..<playerController.files.count), id: \.self) { index in
                    let file = playerController.files[index]
                    NavigationLink(
                        destination: PlayView(
                            pathToFile: file,
                            index: index,
                            selection: $selection
                        ),
                        tag: index,
                        selection: $selection
                    ) {
                        HStack {
                            Image(systemName: "person.circle.fill")
                                .font(.system(size: 24))
                                .scaledToFit()
                            
                            Text(getSongName(path: file))
                                .bold()
                                .padding(.vertical, 2.0)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                        }
                        .padding(4)
                    }
                }

                ChooseFileButton(onSelected: { url in
                    DispatchQueue.main.async {
                        self.playerController.appendFile(link: url)
                    }
                })                
            }
            .toolbar {
                #if os(macOS)
                ToolbarItem {
                    Button(action: {
                        NSApp.keyWindow?.firstResponder?.tryToPerform(
                            #selector(NSSplitViewController.toggleSidebar(_:)),
                            with: nil
                        )
                    }) {
                        Image(systemName: "sidebar.squares.left")
                    }
                }
                #endif
            }
            .listRowInsets(EdgeInsets())
            .frame(minWidth: 300)
            .listStyle(SidebarListStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
