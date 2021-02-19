//
//  ContentView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI

struct ContentView: View {
    // TODO: this should probably be stored in the app state or something
    @State var isPlaying = false

    var body: some View {
        SongList(isPlaying: $isPlaying)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
