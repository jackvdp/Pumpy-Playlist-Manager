//
//  MusicModels.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 11/02/2022.
//

import Foundation

class Playlist: Hashable {
    static func == (lhs: Playlist, rhs: Playlist) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    init(name: String?, tracks: [Track], artworkURL: String?, description: String?, shortDescription: String?, id: String?, spotifyToken: String?) {
        self.name = name
        self.tracks = tracks
        self.artworkURL = artworkURL
        self.description = description
        self.shortDescription = shortDescription
        self.id = id
        self.spotifyToken = spotifyToken
        
        getTracksData()
    }
    
    var name: String?
    var tracks: [Track]
    var artworkURL: String?
    var description: String?
    var shortDescription: String?
    var id: String?
    var uuid = UUID()
    var spotifyToken: String?
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
    
    var lib: LibraryPlaylist {
        if let id = id {
            return LibraryPlaylist(name: name,
                               artworkURL: artworkURL,
                               id: id,
                               shortDescription: shortDescription)
        } else {
            return LibraryPlaylist(name: name, tracks: tracks)
        }
    }
    
    func getTracksData() {
        let uris: [String] = tracks.compactMap { $0.spotifyID }
        if let token = spotifyToken {
            Spotify(spotifyToken: token).getManyTrackFeaturesFromSpotifyID(ids: uris) { features in
                for track in self.tracks {
                    if let feature = features.first(where: { $0.id == track.spotifyID }) {
                        DispatchQueue.main.async {
                            track.audioFeatures = feature
                        }
                    }
                }
            }
        }
    }
}

struct LibraryPlaylist: Codable, Identifiable, Hashable {
    var name: String?
    var artworkURL: String?
    var id: String?
    var shortDescription: String?
    var tracks: [Track]?
}
