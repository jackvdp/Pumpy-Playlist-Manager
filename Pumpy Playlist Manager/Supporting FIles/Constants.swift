//
//  Constants.swift
//  GraphQL Test
//
//  Created by Jack Vanderpump on 10/02/2022.
//

import Foundation

struct K {
    
    struct KeychainKeys {
        static let sybUsernameKey = "userKey"
        static let sybPasswordKey = "passKey"
        static let sybTokenKey = "tokenKey"
        
        static let fireUserKey = "fireUserKey"
        static let firePassKey = "firePassKey"
        static let fireTokenKey = "fireTokenKey"
    }
    
    struct Images {
        static let pumpyArtwork = "Pumpy Artwork"
    }
    
    struct Fire {
        static let playlistLibrary = "playlistLibrary"
        static let playlists = "playlists"
    }
    
    struct MusicStore {
        static let url = "https://api.music.apple.com/v1/"
        static let musicUserToken = "Music-User-Token"
        static let authorisation = "Authorization"
//        static let bearerToken = "Bearer \(K.MusicStore.developerToken)"
    }
}
