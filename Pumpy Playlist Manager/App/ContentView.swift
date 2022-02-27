//
//  ContentView.swift
//  GraphQL Test
//
//  Created by Jack Vanderpump on 10/02/2022.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var playerManager: PlayerManager
    
    var body: some View {
        ZStack(alignment: .bottom) {
            HomeView()
            if playerManager.player != nil {
                PlayerView()
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
