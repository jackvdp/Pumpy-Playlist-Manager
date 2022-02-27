//
//  LibraryViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 16/02/2022.
//

import Foundation

class LibraryViewModel: ObservableObject {
    
    @Published var playlistSelected: LibraryPlaylist?
    
    func activateBack() -> (()->())? {
        if let _ = playlistSelected {
            return { self.playlistSelected = nil }
        } else {
            return nil
        }
    }
    
}
