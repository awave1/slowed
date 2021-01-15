//
//  ChooseFileButton.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-14.
//

import Foundation
import SwiftUI

struct ChooseFileButton: View {
    var onSelected: ((_ path: URL) -> Void)
    
    var body: some View {
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
                onSelected(url)
            }
        }
        
    }
}
