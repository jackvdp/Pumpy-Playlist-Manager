//
//  TrackOverlayView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 20/02/2022.
//

import SwiftUI

struct HoveringView: View {
    
    @EnvironmentObject var playerManager: PlayerManager
    @Binding var isHovering: Bool
    let track: Track
    
    var body: some View {
        ZStack {
            if track == playerManager.currentTrack {
                OverlayView(imageName: playerManager.playerState.rawValue)
            } else {
                if isHovering {
                    OverlayView(imageName: PlayerState.notPlaying.rawValue)
                } else {
                    EmptyView()
                }
            }
        }
        .onTapGesture {
            if playerManager.currentTrack == track {
                playerManager.playPauseMusic()
            } else {
                playerManager.startPlaying(queue: [track])
            }
        }
    }
}

struct OverlayView: View {
    
    let imageName: String
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.black)
                .opacity(0.4)
            Image(systemName: imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height: 20)
                .foregroundColor(.white)
                .opacity(0.7)
        }
    }
}


//struct TrackOverlayView_Previews: PreviewProvider {
//    static var previews: some View {
//        HoveringView()
//    }
//}
