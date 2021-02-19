//
//  ChooseFileButton.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-14.
//

import Foundation
import SwiftUI

private struct ChooseFileButtonStyle: ButtonStyle {
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .font(.headline)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
            .contentShape(Rectangle())
            .foregroundColor(configuration.isPressed ? Color.white.opacity(0.5) : Color.white)
    }
}

struct ChooseFileButton: View {
    var onSelected: ((_ path: URL) -> Void)
    
    var body: some View {
        Button(action: openFilePicker) {
            SongListItem(label: "Choose File", image: "plus.square.fill")
        }
        .buttonStyle(ChooseFileButtonStyle())
    }
    
    private func openFilePicker() {
        let dialog = NSOpenPanel()
        dialog.title = "Choose File"
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
