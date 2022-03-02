//
//  SpotifyAPIParser.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 01/03/2022.
//

import Foundation
import SwiftyJSON

class SpotifyAPIParser {
    
    func parseForTrackFeatures(data: Data) -> AudioFeatures? {
        if let jsonData = try? JSON(data: data) {
            return AudioFeatures(danceability: jsonData["danceability"].float,
                                 energy: jsonData["energy"].float,
                                 key: jsonData["key"].int,
                                 loudness: jsonData["loudness"].float,
                                 tempo: jsonData["tempo"].float,
                                 valence: jsonData["valence"].float,
                                 liveliness: jsonData["liveness"].float,
                                 id: jsonData["id"].string)
        }
        return nil
    }
    
    func parseForManyTrackFeatures(data: Data) -> [AudioFeatures] {
        if let jsonData = try? JSON(data: data) {
            if let afArray = jsonData["audio_features"].array {
                return afArray.map { item in
                    AudioFeatures(danceability: item["danceability"].float,
                                  energy: item["energy"].float,
                                  key: item["key"].int,
                                  loudness: item["loudness"].float,
                                  tempo: item["tempo"].float,
                                  valence: item["valence"].float,
                                  liveliness: item["liveness"].float,
                                  id: item["id"].string)
                }
            }
        }
        return []
    }
    
    func parseForSpotifyID(data: Data) -> String? {
        if let jsonData = try? JSON(data: data) {
            if let tracks = jsonData["tracks"].dictionary {
                if let items = tracks["items"]?.array {
                    for item in items {
                        if let id = item["id"].string {
                            return id
                        }
                    }
                }
            }
        }
        return nil
    }
}
