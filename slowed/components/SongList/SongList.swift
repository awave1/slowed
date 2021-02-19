//
//  SongList.swift
//  slowed
//
//  Created by Artem Golovin on 2021-02-19.
//

import Foundation
import SwiftUI

struct SongList: View {
    @State var pathToFile: URL?
    @State var selection: Int? = 0
    @State var displayControls = false

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
                                selection: $selection,
                                displayControls: $displayControls
                            ),
                            tag: index,
                            selection: $selection
                        ) {
                            SongListItem(
                                label: getSongName(path: file),
                                image: "person.circle.fill"
                            )
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
                    ToolbarItemGroup {
                        Button(action: {
                            NSApp.keyWindow?.firstResponder?.tryToPerform(
                                #selector(NSSplitViewController.toggleSidebar(_:)),
                                with: nil
                            )
                        }, label: {
                            Image(systemName: "sidebar.squares.left")
                        })

                        Menu {
                            Toggle(isOn: $displayControls) {
                                Label("Display controls", systemImage: "star.fill")
                            }
                        } label: {
                            Label("Settings", systemImage: "slider.horizontal.3")
                        }
//                        ToolbarItem {
//
//                        }
                    }
                    #endif
                }
                .listRowInsets(EdgeInsets())
                .frame(minWidth: 300)
                .listStyle(SidebarListStyle())
        }
    }
}
