//
//  SortPlaylist.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 01/03/2022.
//

import Foundation

extension PlaylistViewModel {
    
    func sortTracks() {
        switch sortBy {
        case .standard:
            sortedTracks = playlist.tracks
        case .title:
            sortedTracks = playlist.tracks.sorted(by: {
                if $0.title == $1.title {
                    return $0.artist < $1.artist
                } else {
                    return $0.title < $1.title
                }
            } )
        case .artist:
            sortedTracks = playlist.tracks.sorted(by: {
                if $0.artist == $1.artist {
                    return $0.title < $1.title
                } else {
                    return $0.artist < $1.artist
                }
            } )
        case .recognizability:
            sortedTracks = playlist.tracks.sorted(by: {
                if $0.recognizability == $1.recognizability {
                    return $0.artist < $1.artist
                } else {
                    return $0.recognizability ?? 0 > $1.recognizability ?? 0
                }
            } )
        case .bpm:
            sortedTracks = playlist.tracks.sorted(by: {
                if $0.audioFeatures?.tempo == $1.audioFeatures?.tempo {
                    return $0.artist < $1.artist
                } else {
                    return $0.audioFeatures?.tempo ?? 0 > $1.audioFeatures?.tempo ?? 0
                }
            } )
        case .dance:
            sortedTracks = playlist.tracks.sorted(by: {
                if $0.audioFeatures?.danceability == $1.audioFeatures?.danceability {
                    return $0.artist < $1.artist
                } else {
                    return $0.audioFeatures?.danceability ?? 0 > $1.audioFeatures?.danceability ?? 0
                }
            } )
        case .energy:
            sortedTracks = playlist.tracks.sorted(by: {
                if $0.audioFeatures?.energy == $1.audioFeatures?.energy {
                    return $0.artist < $1.artist
                } else {
                    return $0.audioFeatures?.energy ?? 0 > $1.audioFeatures?.energy ?? 0
                }
            } )
        }
    }
    
}

enum SortTracks: String, CaseIterable, Identifiable {
    case standard = "Playlist"
    case title = "Title"
    case artist = "Artist"
    case recognizability = "Popular"
    case bpm = "BPM"
    case dance = "Danceability"
    case energy = "Energy"
    
    var id: Self { self }
}
