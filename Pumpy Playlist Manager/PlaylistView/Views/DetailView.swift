//
//  DetailView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import SwiftUI
import CachedAsyncImage

struct DetailView: View {
    @ObservedObject var playlistVM: PlaylistViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(playlistVM.playlist.name ?? "N/A")
                    .font(.title)
                Text("\(playlistVM.playlist.tracks.count) tracks")
                    .opacity(0.5)
                Spacer()
                ButtonsView(playlistVM: playlistVM)
                Spacer()
                Text(playlistVM.playlist.description ?? "")
            }
            Spacer()
            CachedAsyncImage(url: URL(string: playlistVM.playlist.artworkURL?.getArtworkURLForSize(150) ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image(K.Images.pumpyArtwork)
                    .resizable()
            }
            .cornerRadius(10)
            .frame(width: 150, height: 150)
        }
        .frame(height: 150)
        .padding(.horizontal)
    }
}



struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(playlistVM: PlaylistViewModel(MockData.mockPlaylist))
            .environmentObject(PlayerManager())
            .environmentObject(LibraryManager())
    }
}
