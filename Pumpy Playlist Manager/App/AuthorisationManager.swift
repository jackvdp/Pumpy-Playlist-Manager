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
        if let musicURL = URL(string: "https://accounts.spotify.com/api/token") {
            let body = String("grant_type=client_credentials").data(using: .utf8)
            var musicRequest = URLRequest(url: musicURL)
            musicRequest.httpMethod = "POST"
            
            let headerValue = String("\(clientID):\(clientSecret)").toBase64()
            
            musicRequest.addValue("Basic \(headerValue)", forHTTPHeaderField: K.MusicStore.authorisation)
            musicRequest.httpBody = body
            
            URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
                guard error == nil else { return }
                if let d = data {
                    self.parseToken(data: d)
                    
                }
            }.resume()
        }
    }
    
    private func parseToken(data: Data) {
        if let jsonData = try? JSON(data: data) {
            print(jsonData)
            if let token = jsonData["access_token"].string {
                spotifyToken = token
                renewToken(time: jsonData["expires_in"].int ?? 120)
            }
        }
    }
    
    private func renewToken(time: Int) {
        renewTokenTimer = Timer.scheduledTimer(withTimeInterval: TimeInterval(time-60), repeats: true) { timer in
            self.getSpotifyToken()
        }
    }
}
