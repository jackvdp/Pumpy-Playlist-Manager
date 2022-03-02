//
//  SpotifyAPI.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 01/03/2022.
//

import Foundation
import SwiftyJSON

class Spotify {
    
    let storefrontID: String
    let spotifyToken: String
    let spotifyParser = SpotifyAPIParser()
    
    init(spotifyToken: String, storefrontID: String = "gb") {
        self.storefrontID = storefrontID
        self.spotifyToken = spotifyToken
    }
    
    func getTrackFeaturesFromSpotifyID(id: String, completion: @escaping (AudioFeatures) -> ()) {
        if let musicURL = URL(string: "https://api.spotify.com/v1/audio-features/\(id)") {
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "GET"
            musicRequest.addValue("Bearer \(spotifyToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                guard error == nil else { return }
                if let d = data {
                    if let features = self.spotifyParser.parseForTrackFeatures(data: d) {
                        completion(features)
                    }
                }
            }.resume()
        }
    }
    
    func getManyTrackFeaturesFromSpotifyID(ids: [String], completion: @escaping ([AudioFeatures]) -> ()) {
        let pages: [[String]] = ids.chunks(100)
        
        pages.forEach { page in
            
            if let musicURL = URL(string: "https://api.spotify.com/v1/audio-features/?ids=\(page.joined(separator: ","))") {
                var musicRequest = URLRequest(url: musicURL)
                musicRequest.httpMethod = "GET"
                musicRequest.addValue("Bearer \(spotifyToken)", forHTTPHeaderField: "Authorization")
                
                URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                    guard error == nil else { return }
                    if let d = data {
                        let features = self.spotifyParser.parseForManyTrackFeatures(data: d)
                        completion(features)
                    }
                }.resume()
            }
            
        }
    }
    
    func getSpotifyTrackFromISRC(isrc: String, completion: @escaping (String) -> ()) {
        if let musicURL = URL(string: "https://api.spotify.com/v1/search?type=track&q=isrc:\(isrc)") {
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "GET"
            musicRequest.addValue("Bearer \(spotifyToken)", forHTTPHeaderField: "Authorization")
            
            URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                guard error == nil else { return }
                if let d = data {
                    if let id = self.spotifyParser.parseForSpotifyID(data: d) {
                        completion(id)
                    }
                }
            }.resume()
        }
    }
    
}
