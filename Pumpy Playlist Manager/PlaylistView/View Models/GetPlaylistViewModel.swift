//
//  PlaylistViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 11/02/2022.
//

import Foundation
import SwiftUI
import Apollo

class GetPlaylistViewModel: ObservableObject {
    
    @Published var playlistRecieved: Playlist?
    @Published var errorMessage: ErrorMessage = ErrorMessage("Error", "")
    @Published var showError = false
    @Published var isSearching = false
    
    let id: String
    
    init(id: String) {
        self.id = id
        getPlaylist()
    }
    
    private func getPlaylist() {
        isSearching = true
        let query = GetPlaylistQuery(playlistID: id)
        
        Apollo.shared.client.fetch(query: query) { result in
            self.isSearching = false
            switch result {
            case .success(let data):
                print("Got data")
                self.dealWithData(data)
            case .failure(let error):
                self.errorMessage = ErrorMessage("Error loading Playlist", "Error loading data: \(error.localizedDescription).")
                self.showError = true
            }
        }
    }
    
    private func dealWithData(_ data: GraphQLResult<GetPlaylistQuery.Data>) {
        
        if let playlist = data.data?.playlist {
            
            if let tracks = playlist.tracks?.edges {
                
                let decodedTracks: [Track] = tracks.compactMap { track in
                    let trk = track.node
                    if let isrc = trk.isrc {
                        return Track(
                            title: trk.title,
                            artist: trk.artists?.first?.name ?? "N/A",
                            album: trk.album?.title ?? "N/A",
                            isrc: isrc,
                            artworkURL: trk.display?.image?.placeholder,
                            previewUrl: trk.previewUrl,
                            recognizability: trk.recognizability,
                            shareURL: trk.shareUrl
                        )
                    } else {
                        return nil
                    }
                }
                
                playlistRecieved = Playlist(name: playlist.name,
                                            tracks: decodedTracks,
                                            artworkURL: playlist.display?.image?.placeholder,
                                            description: playlist.description,
                                            shortDescription: playlist.shortDescription,
                                            id: id)
            }
        } else {
            self.errorMessage = ErrorMessage("Error loading Playlist", "Error loading data: Invalid Playlist ID.")
            self.showError = true
        }
        
    }
    
}

