//
//  GraphQL_TestApp.swift
//  GraphQL Test
//
//  Created by Jack Vanderpump on 10/02/2022.
//

import SwiftUI
import Firebase

@main
struct PumpyPlaylistManager: App {
    
    @StateObject var playerManager = PlayerManager()
    @StateObject var accountManager = AccountManager()
    @StateObject var libraryManager = LibraryManager()
    @StateObject var authroisationManager = AuthorisationManager()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 800,
                       maxWidth: .infinity,
                       minHeight: 400,
                       maxHeight: .infinity,
                       alignment: .center)
                .environmentObject(playerManager)
                .environmentObject(accountManager)
                .environmentObject(libraryManager)
                .environmentObject(authroisationManager)
        }
    }
}
