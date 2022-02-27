//
//  ButtonsView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import SwiftUI

struct ButtonsView: View {
    @EnvironmentObject var playerManager: PlayerManager
    @EnvironmentObject var libraryManager: LibraryManager
    @State private var hoverPlayButton = false
    @State private var hoverAddButton = false
    
    @ObservedObject var playlistVM: PlaylistViewModel
    
    var body: some View {
        HStack(alignment: .top) {
            Button(action: {
                playerManager.startPlaying(queue: playlistVM.playlist.tracks.shuffled())
            }) {
                Image(systemName: "play.fill")
                    .frame(width: 50, height: 50)
                    .font(.largeTitle)
                    .foregroundColor(.white)
                    .background(hoverPlayButton ? Color.pumpyPinkDark : Color.pumpyPink)
                    .clipShape(Circle())
                    .onHover { isHovering in
                        hoverPlayButton = isHovering
                    }
            }
            .buttonStyle(.plain)
            Button(action: {
                libraryManager.addRemovePlaylistFromLibrary(playlistVM.playlist.lib)
            }) {
                Image(systemName:
                        libraryManager.isInLibrary(playlistVM.playlist.lib) ? "checkmark" : "plus"
                )
                    .frame(width: 35, height: 35)
                    .font(.title2)
                    .foregroundColor(hoverAddButton ? .black : .white)
                    .background(!hoverAddButton ? .black : .white)
                    .clipShape(Circle())
                    .onHover { isHovering in
                        hoverAddButton = isHovering
                    }
            }
            .buttonStyle(.plain)
        }
    }
}

struct ButtonsView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonsView(playlistVM: PlaylistViewModel(MockData.mockPlaylist))
            .environmentObject(PlayerManager())
            .environmentObject(LibraryManager())
    }
}
