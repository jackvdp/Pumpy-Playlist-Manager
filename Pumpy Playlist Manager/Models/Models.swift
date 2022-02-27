//
//  Models.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import Foundation
import SwiftUI

struct ErrorMessage {
    var title: String
    var message: String
    
    init(_ title: String, _ message: String) {
        self.title = title
        self.message = message
    }
}

enum PlayerState: String {
    case playing = "pause.fill"
    case notPlaying = "play.fill"
}
