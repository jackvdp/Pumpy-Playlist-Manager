//
//  PlaylistView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import SwiftUI
import ActivityIndicatorView

struct GetPlaylistView: View {
    
    @StateObject var getPlaylistVM: GetPlaylistViewModel

    var body: some View {
        VStack {
            if let p = getPlaylistVM.playlistRecieved {
                PlaylistView(playlistVM: PlaylistViewModel(p))
            } else {
                AppActivityIndicatorView(isVisible: $getPlaylistVM.isSearching)
            }
        }
        .padding()
        .alert(getPlaylistVM.errorMessage.title, isPresented: $getPlaylistVM.showError) {
            Button("OK") {}
        } message: {
            Text(getPlaylistVM.errorMessage.message)
        }
    }
}

struct PlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        GetPlaylistView(getPlaylistVM: GetPlaylistViewModel(id: "encfeknj"))
    }
}


