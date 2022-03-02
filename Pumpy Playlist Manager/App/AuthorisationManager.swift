//
//  AuthorisationManager.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 27/02/2022.
//

import Foundation
import SwiftyJSON

class AuthorisationManager: ObservableObject {
    
    private let clientID = "792bd55fbacc4d16bf0fad19b064fa2a"
    private let clientSecret = "c5dde1a348874970b156e44775d31a6f"
    private var renewTokenTimer: Timer?
    var spotifyToken: String?
    
    init() {
        getSpotifyToken()
    }
    
    func getSpotifyToken() {
        SpotifyTokenParser().getSpotifyToken(clientID: clientID, clientSecret: clientSecret) { token, renewTime in
            self.spotifyToken = token
            self.renewToken(time: renewTime)
        }
    }
    
    private func renewToken(time: Int) {
        renewTokenTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time-60), repeats: true) { timer in
            self.getSpotifyToken()
        }
    }
}
