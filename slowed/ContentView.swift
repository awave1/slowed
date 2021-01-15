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
                
                ChooseFileButton(onSelected: { url in
                    pathToFile = url
                    conductor.load(path: url)
                })
            }
            
            PlayerControls(conductor: conductor)
        }
        .frame(minWidth: 700, minHeight: 300)
        .padding()

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
