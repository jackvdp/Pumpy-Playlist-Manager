//
//  TrackModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 25/02/2022.
//

import Foundation

class Track: Identifiable, Hashable, ObservableObject, Codable {
    static func == (lhs: Track, rhs: Track) -> Bool {
        return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
    }
    
    init(title: String, artist: String, album: String, isrc: String, artworkURL: String?, previewUrl: String?, recognizability: Int?, shareURL: String?, sybID: String, isFromPlaylist: Bool = true, spotifyToken: String?) {
        self.title = title
        self.artist = artist
        self.album = album
        self.isrc = isrc
        self.artworkURL = artworkURL
        self.previewUrl = previewUrl
        self.recognizability = recognizability
        self.isFromPlaylist = isFromPlaylist
        self.sybID = sybID
        self.spotifyID = getSpoitfyID(shareURL)
        self.spotifyToken = spotifyToken
        
        getTrackStats()
    }
    
    var title: String
    var artist: String
    var album: String
    var isrc: String
    var artworkURL: String?
    var previewUrl: String?
    var recognizability: Int?
    var spotifyID: String?
    var sybID: String
    @Published var audioFeatures: AudioFeatures?
    var isFromPlaylist: Bool?
    var id = UUID()
    var spotifyToken: String?
    
    
    var hashValue: Int {
        return ObjectIdentifier(self).hashValue
    }
    
    func getSpoitfyID(_ shareURL: String?) -> String? {
        if let url = shareURL {
            if let component = url.split(separator: "/").last {
                print(component)
                return String(component)
            }
        }
        return nil
    }
    
    func getTrackStats() {
        if let token = spotifyToken {
            let spotify = Spotify(spotifyToken: token)
            if let spotID = spotifyID {
                if !(isFromPlaylist ?? false) {
                    spotify.getTrackFeaturesFromSpotifyID(id: spotID) { feature in
                        self.audioFeatures = feature
                    }
                }
            } else {
                spotify.getSpotifyTrackFromISRC(isrc: isrc) { spotifyTrackID in
                    spotify.getTrackFeaturesFromSpotifyID(id: spotifyTrackID) { feature in
                        DispatchQueue.main.async {
                            self.audioFeatures = feature
                        }
                    }
                }
            }
        }
    }
    
    enum CodingKeys: CodingKey {
        case title, artist, album, isrc, sybID
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        artist = try container.decode(String.self, forKey: .artist)
        album = try container.decode(String.self, forKey: .album)
        isrc = try container.decode(String.self, forKey: .isrc)
        sybID = try container.decode(String.self, forKey: .sybID)
    }
    
    func encode(to encoder: Encoder) throws {
        audioFeatures = nil
    }

}

