//
//  TrackModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 25/02/2022.
//

import Foundation

struct Track: Identifiable, Hashable {
    
    init(title: String, artist: String, album: String, isrc: String, artworkURL: String?, previewUrl: String?, recognizability: Int?, shareURL: String?, isFromPlaylist: Bool = true) {
        self.title = title
        self.artist = artist
        self.album = album
        self.isrc = isrc
        self.artworkURL = artworkURL
        self.previewUrl = previewUrl
        self.recognizability = recognizability
        self.isFromPlaylist = isFromPlaylist
        self.spotifyID = getSpoitfyID(shareURL)
    }
    
    var title: String
    var artist: String
    var album: String
    var isrc: String
    var artworkURL: String?
    var previewUrl: String?
    var recognizability: Int?
    var spotifyID: String?
    var audioFeatures: AudioFeatures?
    var isFromPlaylist: Bool
    var id = UUID()
    
    func getSpoitfyID(_ shareURL: String?) -> String? {
        if let url = shareURL {
            if let component = url.split(separator: "/").last {
                return String(component)
            }
        }
        
        return nil
    }
    
    func getTrackStats() {
        if let spotID = spotifyID {
            if !isFromPlaylist {
                Spotify().getTrackAudioFeatures(spotID)
            }
        } else {
            // search for track with ISRC
        }
    }
}
