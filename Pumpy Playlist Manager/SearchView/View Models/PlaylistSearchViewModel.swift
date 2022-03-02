//
//  PlaylistSearchViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 18/02/2022.
//

import Foundation

class PlaylistSearchViewModel: SearchViewModel {
    
    @Published var searchTerm = String()
    @Published var libraryPlaylist: LibraryPlaylist?
    @Published var errorMessage: ErrorMessage = ErrorMessage("Error", "")
    @Published var showError = false
    
    let placeHolderText: String = "Enter playlist URL..."
    
    func clearSearch() {
        searchTerm = String()
    }
    
    func runSearch() {
        if searchTerm != "" {
            if let component = searchTerm.split(separator: "/").last {
                let id = String(component)
                libraryPlaylist = LibraryPlaylist(name: "", artworkURL: nil, id: id, shortDescription: nil, tracks: nil)
                return
            }
            libraryPlaylist = nil
            errorMessage = ErrorMessage("Invalid URL", "Please provide a URL containing the playlist ID as the final component.")
            self.showError = true
        }
    }
    
}
