//
//  PlaylistSearchViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 18/02/2022.
//

import Foundation

class PlaylistSearchViewModel: SearchViewModel {
    
    @Published var searchTerm = String()
    @Published var playlistID: String?
    @Published var errorMessage: ErrorMessage = ErrorMessage("Error", "")
    @Published var showError = false
    
    let placeHolderText: String = "Enter playlist URL..."
    
    func clearSearch() {
        searchTerm = String()
    }
    
    func runSearch() {
        if searchTerm != "" {
            if let component = searchTerm.split(separator: "/").last {
                playlistID = String(component)
                return
            }
            playlistID = nil
            errorMessage = ErrorMessage("Invalid URL", "Please provide a URL containing the playlist ID as the final component.")
            self.showError = true
        }
    }
    
}
