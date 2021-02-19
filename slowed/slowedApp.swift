//
//  slowedApp.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI

@main
struct SlowedApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 700, minHeight: 300)
        }
        .commands {
            // Commands go here
            SidebarCommands()
        }
    }
}
