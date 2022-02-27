//
//  PlaylistViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 18/02/2022.
//

import Foundation

class PlaylistViewModel: ObservableObject {
    
    let playlist: Playlist
    var lastSearchTerm = String()
    @Published var displayedTracks: [Track]
    @Published var sortedTracks: [Track] {
        didSet {
            filterResults(lastSearchTerm)
        }
    }
    @Published var sortBy = SortTracks.standard {
        didSet {
            sortTracks()
        }
    }
    
    init(_ playlist: Playlist) {
        self.playlist = playlist
        displayedTracks = playlist.tracks
        sortedTracks = playlist.tracks
    }
    
    func filterResults(_ searchTerm: String) {
        lastSearchTerm = searchTerm
        if searchTerm.isEmpty {
            displayedTracks = sortedTracks
        } else {
            displayedTracks = filterTracks(search: searchTerm)
        }
    }
    
    private func filterTracks(search: String) -> [Track] {
        let searchText = search.lowercased()
        
        return sortedTracks.filter {
            let argumentTitle = $0.title.lowercased()
            let argumentArtist = $0.artist.lowercased()

            return argumentTitle.lowercased().contains(searchText) || argumentArtist.contains(searchText)
        }
    }
    
    private func sortTracks() {
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
        }
    }
}

enum SortTracks: String, CaseIterable, Identifiable {
    case standard = "Playlist"
    case title = "Title"
    case artist = "Artist"
    case recognizability = "Known"
    
    var id: Self { self }
}
