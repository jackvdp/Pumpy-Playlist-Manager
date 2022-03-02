//
//  LibraryManager.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import Foundation
import Firebase
import CodableFirebase

class LibraryManager: ObservableObject {
    
    @Published var libraryPlaylists = [LibraryPlaylist]()
    var listener: ListenerRegistration?
    let libraryAPI = LibraryAPIModel()
    
    init() {
        downloadPlaylists()
    }
    
    deinit {
        listener?.remove()
    }
    
    func downloadPlaylists() {
        if let username = UserDefaults.standard.string(forKey: K.KeychainKeys.fireUserKey) {
            listener = libraryAPI.downloadPlaylists(username: username) { playlists in
                self.libraryPlaylists = playlists
            }
        }
    }
    
    func addRemovePlaylistFromLibrary(_ playlist: LibraryPlaylist) {
        if libraryPlaylists.contains(playlist){
            libraryAPI.removePlaylistFromLibrary(playlist: playlist)
        } else {
            libraryAPI.addPlaylistToLibrary(playlist: playlist)
        }
    }
    
    func isInLibrary(_ playlist: LibraryPlaylist) -> Bool {
        libraryPlaylists.contains(playlist)
    }
    
    
} 
