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

    @EnvironmentObject var state: AppState

    var body: some View {
        NavigationView {
            List {
                ForEach((0..<self.state.getSongCount()), id: \.self) { index in
                    let file = state.songs[index]
                    NavigationLink(
                        destination: PlayView(
                            pathToFile: file,
                            index: index,
                            selection: $selection
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

                ChooseFileButton()
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
                        Toggle(isOn: $state.displayControls) {
                            Label("Display controls", systemImage: "star.fill")
                        }
                    } label: {
                        Label("Settings", systemImage: "slider.horizontal.3")
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
