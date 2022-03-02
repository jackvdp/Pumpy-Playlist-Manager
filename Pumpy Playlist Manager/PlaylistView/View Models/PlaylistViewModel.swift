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
    
}
