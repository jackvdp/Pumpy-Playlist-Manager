//
//  SpotifyAPI.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 24/02/2022.
//

import Foundation
import SpotifyWebAPI
import Combine

class Spotify {
    
    let api = SpotifyAPI(
        authorizationManager: AuthorizationCodeFlowManager(
            clientId: "792bd55fbacc4d16bf0fad19b064fa2a",
            clientSecret: "c5dde1a348874970b156e44775d31a6f"
        )
    )
    
    var subscriptions: Set<AnyCancellable> = []
    
    func getTracksAudioFeatures(_ tracks: [String]) {
            api.tracksAudioFeatures(tracks)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully completed")
                    
                case .failure(let error):
                    print("***** \(error)")
                    
                }
            }, receiveValue: { value in
                print("\(value)")
                
            })
            .store(in: &subscriptions)
    }
    
    func getTrackAudioFeatures(_ track: String) {
        api.trackAudioFeatures(track)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("successfully completed")
                case .failure(let error):
                    print(error)
                }
            }, receiveValue: { value in
                print("\(value)")
            })
            .store(in: &subscriptions)
    }
    
}
