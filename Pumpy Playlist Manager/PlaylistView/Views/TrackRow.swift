//
//  PlaylistViewRow.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 11/02/2022.
//

import SwiftUI
import CachedAsyncImage

struct TrackRow: View {
    
    @ObservedObject var track: Track
    @State var isHovering = false
    
    var body: some View {
        HStack {
            artwork
            VStack(alignment: .leading) {
                Text(track.title)
                Text(track.artist)
                    .font(.subheadline)
                    .opacity(0.5)
            }
            Spacer()
            trackStats
        }
    }
    
    var artwork: some View {
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
    }
    
    var trackStats: some View {
        HStack(spacing: 20) {
            Divider()
            VStack(alignment: .trailing) {
                StatRow(label: "Dance:", value: "\(track.audioFeatures?.danceabilityString ?? "–")")
                StatRow(label: "Energy:", value: "\(track.audioFeatures?.energyString ?? "–%")")
            }
            Divider()
            VStack(alignment: .trailing) {
                StatRow(label: "BPM:", value: track.audioFeatures?.tempoString ?? "–%")
                StatRow(label: "Popular:", value: "\(track.recognizability?.description ?? "–")%")
            }
        }
    }
        
}

struct PlaylistViewRow_Previews: PreviewProvider {
    static var previews: some View {
        TrackRow(track: MockData.mockTrack)
            .environmentObject(PlayerManager())
    }
}

struct StatRow: View {
    var label: String
    var value: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
            Spacer()
            Text(value)
                .font(.subheadline)
        }
        .frame(width: 100)
    }
}
