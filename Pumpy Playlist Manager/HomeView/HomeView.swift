//
//  HomeView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 14/02/2022.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack(alignment: .leading) {
                Header(title: "Pumpy Playlist Manager")
                List {
                    MenuItem(destination: EmptyView(),
                             label: "Home",
                             image: "house.fill")
                    MenuItem(destination: LibraryView(libraryVM: LibraryViewModel(mode: .library)),
                             label: "Library",
                             image: "music.note.list")
                    MenuItem(destination: LibraryView(libraryVM: LibraryViewModel(mode: .create)),
                             label: "Create Playlist",
                             image: "bonjour")
                    MenuItem(destination: SearchView(),
                             label: "Search",
                             image: "magnifyingglass")
                    MenuItem(destination: LoginView(),
                             label: "Accounts",
                             image: "person.fill")
                }
                .frame(minWidth: 150, maxWidth: 250)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(PlayerManager())
            .environmentObject(AccountManager())
            .environmentObject(LibraryManager())
    }
}
