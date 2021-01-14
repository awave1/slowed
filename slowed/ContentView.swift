//
//  ContentView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI
import AudioKit
import AVFoundation


struct ContentView: View {
    @State var pathToFile: URL?
    var conductor = SlowedAudioEngine()
    
    var body: some View {
        VStack {
            VStack {
                if pathToFile != nil {
                    Text("loaded: \(pathToFile!.absoluteString)")
                } else {
                    Text("load file")
                }
            }
                
            Button("Choose file") {
                let dialog = NSOpenPanel()
                dialog.title = "Choose a file"
                dialog.canChooseFiles = true
                dialog.canChooseDirectories = false
                dialog.showsHiddenFiles = false
                
                let status = dialog.runModal()
                if (status != NSApplication.ModalResponse.OK) {
                    return
                }
                
                let result = dialog.url
                if let url = result?.absoluteURL {
                    pathToFile = url
                    conductor.load(path: url)
                }
            }
            
            PlayerControls(conductor: conductor)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 500, height: 500, alignment: .center)
    }
}
