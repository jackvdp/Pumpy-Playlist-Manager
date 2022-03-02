//
//  LibraryView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import SwiftUI

struct LibraryView: View {
    
    @EnvironmentObject var libraryManager: LibraryManager
    @EnvironmentObject var authManager: AuthorisationManager
    @StateObject var libraryVM: LibraryViewModel
    
    var body: some View {
        VStack {
            Header(title: libraryVM.headerTitle(),
                   backFunction: libraryVM.showBack())
            Spacer()
            switch libraryVM.libraryNav {
            case .library:
                LibraryGridView(libraryVM: libraryVM)
            case .playlist(let playlist):
                GetPlaylistView(getPlaylistVM: GetPlaylistViewModel(libraryPlaylist: playlist, spotifyToken: authManager.spotifyToken))
            case .customPlaylist:
                CreatePlaylistView()
            }
            Spacer()
        }
    }
    
}

struct LibraryView_Previews: PreviewProvider {
    
    static let libraryManager = LibraryManager()
    
    static var previews: some View {
        return LibraryView(libraryVM: LibraryViewModel(mode: .library))
            .environmentObject(libraryManager)
            .environmentObject(PlayerManager())
            .environmentObject(AccountManager())
            .frame(width: 800, height: 400)
    }
}
