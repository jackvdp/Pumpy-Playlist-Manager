//
//  PlaylistViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 11/02/2022.
//

import Foundation
import SwiftUI
import Apollo

class GetPlaylistViewModel: ObservableObject {
    
    @Published var playlistRecieved: Playlist?
    @Published var errorMessage: ErrorMessage = ErrorMessage("Error", "") {
        didSet {
            showError.toggle()
        }
    }
    @Published var showError = false
    @Published var isSearching = false

    let getPlaylistModel: GetPlaylistModel
    
    init(libraryPlaylist: LibraryPlaylist, spotifyToken: String?) {
        getPlaylistModel = GetPlaylistModel(libraryPlaylist: libraryPlaylist, spotifyToken: spotifyToken)
        getPlaylist()
    }
    
    private func getPlaylist() {
        isSearching = true
        
        getPlaylistModel.getPlaylist { playlist, error in
            self.isSearching = false
            if let e = error {
                self.errorMessage = e
            }
            if let p = playlist {
                self.playlistRecieved = p
            }
        }
        
    }

}

