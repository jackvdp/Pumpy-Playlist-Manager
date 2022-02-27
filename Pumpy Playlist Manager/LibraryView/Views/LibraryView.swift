//
//  LibraryView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import SwiftUI

struct LibraryView: View {
    
    @EnvironmentObject var libraryManager: LibraryManager
    @StateObject var libraryVM = LibraryViewModel()
    
    var body: some View {
        VStack {
            Header(title: "Library", backFunction: libraryVM.activateBack())
            Spacer()
            if libraryManager.libraryPlaylists.isEmpty {
                Text("No playlists saved")
                    .font(.title)
            } else {
                if libraryVM.playlistSelected == nil {
                    LibraryGridView(libraryVM: libraryVM)
                } else if let playlist = libraryVM.playlistSelected {
                    GetPlaylistView(getPlaylistVM: GetPlaylistViewModel(id: playlist.id))
                }
                
            }
            Spacer()
        }
    }
    
}

struct LibraryView_Previews: PreviewProvider {
    
    static let libraryManager = LibraryManager()
    
    static var previews: some View {
        //        libraryManager.libraryPlaylists = [MockData.mockLibraryPlaylist]
        return LibraryView()
            .environmentObject(libraryManager)
            .environmentObject(PlayerManager())
            .environmentObject(AccountManager())
            .frame(width: 800, height: 400)
    }
}
