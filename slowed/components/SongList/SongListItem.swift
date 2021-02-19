//
//  SongListItem.swift
//  slowed
//
//  Created by Artem Golovin on 2021-02-19.
//

import Foundation
import SwiftUI

struct SongListItem: View {
    var label: String
    var image: String

    var body: some View {
        HStack {
            Image(systemName: image)
                .font(.system(size: 24))
                .scaledToFit()
                .padding(.trailing, 8)

            Text(label)
                .bold()
                .padding(.vertical, 2.0)
                .foregroundColor(.primary)
                .lineLimit(2)

            Spacer()
        }
        .padding(4)
    }
}
