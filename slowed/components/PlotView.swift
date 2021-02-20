//
//  PlotView.swift
//  slowed
//
//  Created by Artem Golovin on 2021-02-19.
//

import AudioKit
import SwiftUI
import AVFoundation

struct DryWetMixPlotsView: View {
    var mix: NodeOutputPlot

    var body: some View {
        PlotView(view: mix)
            .frame(maxWidth: .infinity, maxHeight: 200, alignment: .bottom)
    }
}

struct PlotView: NSViewRepresentable {
    typealias NSViewType = NodeOutputPlot
    var view: NodeOutputPlot

    func makeNSView(context: Context) -> NodeOutputPlot {
        view.backgroundColor = NSColor.clear
        view.plotType = .buffer
        view.color = NSColor.red.withAlphaComponent(0.5)
        return view
    }

    func updateNSView(_ NSView: NodeOutputPlot, context: Context) {
        //
    }

}
