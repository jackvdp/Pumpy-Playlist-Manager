//
//  AudioFeaturesModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 25/02/2022.
//

import Foundation

struct AudioFeatures: Codable, Hashable {
    var danceability: Float? //  how dancey a track is based on elements including tempo, rhythm stability, beat strength, and overall regularity
    var energy: Float? // energetic tracks feel fast, loud, and noisy. For example, death metal has high energy
    var key: Int?
    var loudness: Float?
    var tempo: Float? // BPM
    var valence: Float? // Happiness
    var liveliness: Float? // Audience/live music
    var id: String?
    
    var danceabilityString: String {
        if let d = danceability {
            let percentage = d * 100
            let int = Int(percentage)
            return "\(int)%"
        } else {
            return "N/A"
        }
    }
    
    var energyString: String {
        if let d = energy {
            let percentage = d * 100
            let int = Int(percentage)
            return "\(int)%"
        } else {
            return "N/A"
        }
    }
    
    var loudnessString: String {
        if let d = loudness {
            let percentage = d * 100
            let int = Int(percentage)
            return "\(int)%"
        } else {
            return "N/A"
        }
    }
    
    var tempoString: String {
        if let d = tempo {
            let int = Int(d)
            return "\(int)"
        } else {
            return "N/A"
        }
    }
    
    var valenceString: String {
        if let d = valence {
            let percentage = d * 100
            let int = Int(percentage)
            return "\(int)%"
        } else {
            return "N/A"
        }
    }
    
    var livelinessString: String {
        if let d = liveliness {
            let percentage = d * 100
            let int = Int(percentage)
            return "\(int)%"
        } else {
            return "N/A"
        }
    }
}
