//
//  PlaylistViewRow.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 11/02/2022.
//

import SwiftUI
import CachedAsyncImage

struct TrackRow: View {
    
    let track: Track
    @State var isHovering = false
    
    var body: some View {
        HStack {
            CachedAsyncImage(url: URL(string: track.artworkURL?.getArtworkURLForSize(40) ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image(K.Images.pumpyArtwork)
                    .resizable()
            }
            .onHover(perform: { isHovering in
                self.isHovering = isHovering
            })
            .overlay (
                HoveringView(isHovering: $isHovering, track: track)
            )
            .background(Color.black)
            .cornerRadius(5)
            .frame(width: 40, height: 40)
            VStack(alignment: .leading) {
                Text(track.title)
                Text(track.artist)
                    .font(.subheadline)
                    .opacity(0.5)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("– BPM")
                    .font(.subheadline)
                Text("Familiarity: \(track.recognizability?.description ?? "-")%")
                    .font(.subheadline)
            }
        }
    }
    
}

struct PlaylistViewRow_Previews: PreviewProvider {
    
    static let trackRow = TrackRow(track: MockData.mockTrack)
    static var previews: some View {
        return trackRow
    }
}

