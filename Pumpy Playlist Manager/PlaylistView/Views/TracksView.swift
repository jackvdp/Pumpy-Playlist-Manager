//
//  TracksView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 18/02/2022.
//

import SwiftUI

struct TracksView: View {
    let tracks: [Track]
    @State private var selection: Track?
    
    var body: some View {
        List(tracks, id: \.self, selection: $selection) { track in
            TrackRow(track: track)
        }
        .listStyle(.inset(alternatesRowBackgrounds: true))
        .cornerRadius(5)
        .border(Color(NSColor.separatorColor), width: 2)
    }
}

struct TracksView_Previews: PreviewProvider {
    static var previews: some View {
        TracksView(tracks: MockData.mockTracks)
    }
}
