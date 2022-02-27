//
//  MusicModels.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 11/02/2022.
//

import Foundation

struct Playlist: Hashable {
    
    init(name: String, tracks: [Track], artworkURL: String?, description: String?, shortDescription: String?, id: String) {
        self.name = name
        self.tracks = tracks
        self.artworkURL = artworkURL
        self.description = description
        self.shortDescription = shortDescription
        self.id = id
        
        getTracksData()
    }
    
    var name: String
    var tracks: [Track]
    var artworkURL: String?
    var description: String?
    var shortDescription: String?
    var id: String
    var uuid = UUID()
    
    var lib: LibraryPlaylist {
        LibraryPlaylist(name: name,
                        artworkURL: artworkURL,
                        id: id,
                        shortDescription: shortDescription)
    }
    
    func getTracksData() {
        let uris: [String] = tracks.compactMap { track in
            if let id = track.spotifyID {
                return "spotify:track:\(id)"
            } else {
                return nil
            }
        }
        Spotify().getTracksAudioFeatures(uris)
    }
}

struct LibraryPlaylist: Identifiable, Hashable, Codable {
    var name: String
    var artworkURL: String?
    var id: String
    var shortDescription: String?
}

