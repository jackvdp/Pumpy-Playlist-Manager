//
//  MockData.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import Foundation

struct MockData {
    
    static let mockTrack = Track(title: "Numb",
                                 artist: "Pink Floyd",
                                 album: "Dark Side of the Moon",
                                 isrc: "SJHFJTUBEGKYL846",
                                 artworkURL: "",
                                 previewUrl: "",
                                 recognizability: 100,
                                 shareURL: nil,
                                 sybID: "",
                                 spotifyToken: nil
                                )
    
    static let mockTracks = [Track](repeating: mockTrack, count: 200)
    
    static let mockPlaylist = Playlist(name: "Test",
                                       tracks: mockTracks,
                                       artworkURL: nil,
                                       description: "Romantic and elegant jazz for two. A table not too close to the orchestra.",
                                       shortDescription: "Romantic and elegant jazz for two. A table not too close to the orchestra.",
                                       id: "fenrfkrenf",
                                       spotifyToken: "kiklm,kl")
    
    static let mockLibraryPlaylist = LibraryPlaylist(name: "Test", id: "erfnrtujgntrk", shortDescription: "Romantic and elegant jazz for two. A table not too close to the orchestra.")
    
    static let mockLibraryPlaylists = [LibraryPlaylist](repeating: mockLibraryPlaylist, count: 200)
}
