//
//  PlayerView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import SwiftUI
import CachedAsyncImage
import AVKit

struct PlayerView: View {

    @EnvironmentObject var playerManager: PlayerManager
    
    var body: some View {
        ZStack(alignment: .top) {
            HStack(spacing: 25) {
                HStack {
                    CachedAsyncImage(url: URL(string: playerManager.currentTrack?.artworkURL?.getArtworkURLForSize(75) ?? "")) { image in
                        image.resizable()
                    } placeholder: {
                        Image(K.Images.pumpyArtwork)
                            .resizable()
                    }
                    .cornerRadius(5)
                    .frame(width: 75, height: 75)
                    VStack(alignment: .leading) {
                        Text(playerManager.currentTrack?.title ?? "N/A")
                        Text(playerManager.currentTrack?.artist ?? "N/A")
                            .font(.subheadline)
                            .opacity(0.5)
                    }
                }
                Spacer()
                Image(systemName: playerManager.playerState == .playing ? "pause.fill" : "play.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .onTapGesture {
                        playerManager.playPauseMusic()
                    }
                Image(systemName: "forward.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 35, height: 20)
                    .onTapGesture {
                        playerManager.nextTrack()
                    }
                Image(systemName: "xmark.circle")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .opacity(0.5)
                    .onTapGesture {
                        playerManager.quitPlayer()
                    }
            }
            .padding()
            GeometryReader { geo in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .frame(height: 2)
                        .background(.white)
                    Rectangle()
                        .frame(width: geo.size.width * playerManager.currentTime, height: 2)
                        .foregroundColor(Color.pumpyPink)
                }
            }
        }
        .background(Color(NSColor.windowBackgroundColor))
        .frame(height: 100)
    }
    
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView()
            .environmentObject(PlayerManager())
    }
}
