//
//  LibraryViewModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 16/02/2022.
//

import Foundation

class LibraryViewModel: ObservableObject {

    @Published var libraryNav: LibraryNavigation = .library
    @Published var itemsSelected = [LibraryPlaylist]()
    let mode: LibraryMode
    
    init(mode: LibraryMode) {
        self.mode = mode
    }
    
    func showBack() -> (() -> ())? {
        return libraryNav == .library ? nil : { self.libraryNav = .library }
    }
    
    func toggleSelectItem(playlist: LibraryPlaylist) {
        if itemsSelected.contains(playlist) {
            unSelectItem(playlist: playlist)
        } else {
            selectItem(playlist: playlist)
        }
    }
    
    func selectItem(playlist: LibraryPlaylist) {
        switch mode {
        case .library:
            itemsSelected = [playlist]
        case .create:
            itemsSelected.append(playlist)
        }
    }
    
    func unSelectItem(playlist: LibraryPlaylist) {
        switch mode {
        case .library:
            itemsSelected = [playlist]
        case .create:
            itemsSelected.removeAll(where: { $0 == playlist})
        }
    }
    
    func unSelectAllItems() {
        itemsSelected = []
    }
    
    func goToPlaylistView() {
        if !itemsSelected.isEmpty {
            switch mode {
            case .library:
                if let playlist = itemsSelected.first {
                    libraryNav = .playlist(playlist)
                }
            case .create:
                libraryNav = .customPlaylist
            }
        }
    }
    
    func headerTitle() -> String {
        switch libraryNav {
        case .library:
            switch mode {
            case .library:
                return "Library"
            case .create:
                return "Create from Library"
            }
        case .playlist(let playlist):
            return playlist.name ?? "Playlist"
        case .customPlaylist:
            return "Create New Playlist"
        }
    }
    
}

enum LibraryMode {
    case library, create
}

enum LibraryNavigation: Equatable {
    
    case library, playlist(LibraryPlaylist), customPlaylist
    
    static func ==(lhs: LibraryNavigation, rhs: LibraryNavigation) -> Bool {
        switch (lhs, rhs) {
        case (.library, .library):
            return true
        case (.customPlaylist, .customPlaylist):
            return true
        case (let .playlist(lhsLibPlay), let .playlist(rhsLibPlay)):
            return lhsLibPlay.name == rhsLibPlay.name
        default:
            return false
        }
    }
    
}
