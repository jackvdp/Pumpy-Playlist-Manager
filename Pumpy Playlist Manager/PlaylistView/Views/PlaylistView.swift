//
//  PlaylistView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import SwiftUI
import CachedAsyncImage

struct PlaylistView: View {
    @StateObject var playlistVM: PlaylistViewModel
    @StateObject var searchVM = TrackSearchViewModel()
    
    var body: some View {
        VStack(alignment: .trailing) {
            DetailView(playlistVM: playlistVM)
            HStack {
                SortMenuView(playlistVM: playlistVM)
                Spacer()
                SearchBar(searchVM: searchVM)
            }
            TracksView(tracks: playlistVM.displayedTracks)
        }
        .onChange(of: searchVM.searchTerm) { newValue in
            playlistVM.filterResults(newValue)
        }
        .onAppear {
            playlistVM.filterResults(searchVM.searchTerm)
        }
    }
    
}

struct RecievedPlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistView(playlistVM: PlaylistViewModel(MockData.mockPlaylist))
    }
}
