//
//  GetPlaylistModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 01/03/2022.
//

import Foundation
import Apollo

class GetPlaylistModel {
    
    let libraryPlaylist: LibraryPlaylist
    var spotifyToken: String?
    
    init(libraryPlaylist: LibraryPlaylist, spotifyToken: String?) {
        self.libraryPlaylist = libraryPlaylist
        self.spotifyToken = spotifyToken
    }
    
    func getPlaylist(completion: @escaping (Playlist?, ErrorMessage?) -> ()) {
        if let id = libraryPlaylist.id {
            let query = GetPlaylistQuery(playlistID: id)
            Apollo.shared.client.fetch(query: query) { result in
                switch result {
                case .success(let data):
                    print("Got data")
                    let parsing = self.dealWithData(data, playlistID: id)
                    completion(parsing.0, parsing.1)
                case .failure(let error):
                    let errorMessage = ErrorMessage("Error loading Playlist", "Error loading data: \(error.localizedDescription).")
                    completion(nil, errorMessage)
                }
            }
        } else if let tracks = libraryPlaylist.tracks {
            let playlist = createPlaylist(name: libraryPlaylist.name, tracks: tracks)
            completion(playlist, nil)
        } else {
            let errorMessage = ErrorMessage("Error loading Playlist", "Error loading data")
            completion(nil, errorMessage)
        }
    }
    
    private func dealWithData(_ data: GraphQLResult<GetPlaylistQuery.Data>, playlistID: String) -> (Playlist?, ErrorMessage?) {
        
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
                            shareURL: trk.shareUrl,
                            sybID: trk.id,
                            spotifyToken: spotifyToken
                        )
                    } else {
                        return nil
                    }
                }
                
                let playlistRecieved = Playlist(name: playlist.name,
                                            tracks: decodedTracks,
                                            artworkURL: playlist.display?.image?.placeholder,
                                            description: playlist.description,
                                            shortDescription: playlist.shortDescription,
                                            id: playlistID,
                                            spotifyToken: spotifyToken)
                
                return (playlistRecieved, nil)
            }
        }
        let errorMessage = ErrorMessage("Error loading Playlist", "Error loading data: Invalid Playlist ID.")
        return (nil, errorMessage)
        
    }
    
    func createPlaylist(name: String?, tracks: [Track]) -> Playlist {
        return Playlist(name: name,
                        tracks: tracks,
                        artworkURL: nil,
                        description: nil,
                        shortDescription: nil,
                        id: nil,
                        spotifyToken: spotifyToken)
    }
    
}
