//
//  slowedApp.swift
//  slowed
//
//  Created by Artem Golovin on 2021-01-13.
//

import SwiftUI

//class AppDelegate: NSObject, NSApplicationDelegate {
//    func applicationDidFinishLaunching(_ notification: Notification) {
//        // Create the SwiftUI view that provides the window contents.
//        let contentView = ContentView()
//            .edgesIgnoringSafeArea(.top) // to extend entire content under titlebar
//
//        // Create the window and set the content view.
//        let window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 700, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .borderless, .resizable, .fullSizeContentView],
//            backing: .buffered,
//            defer: false
//        )
//        window.center()
//
//        window.isReleasedWhenClosed = false
//        window.titlebarAppearsTransparent = true
//        window.titleVisibility = .hidden
//
//        window.contentView = NSHostingView(rootView: contentView)
//        window.makeKeyAndOrderFront(nil)
//    }
//}

@main
struct slowedApp: App {
//    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 700, minHeight: 300)
                .background(fromHex(hex: "#232946") ?? Color.black)
        }
    }
}
