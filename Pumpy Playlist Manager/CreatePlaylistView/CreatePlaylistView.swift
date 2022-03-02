//
//  CreatePlaylistView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 02/03/2022.
//

import SwiftUI

struct CreatePlaylistView: View {
    
    @StateObject var createPlaylistVM: CreatePlaylistViewModel
    
    var body: some View {
        ScrollView {
            Text("Hello")
        }
    }
}

struct CreatePlaylistView_Previews: PreviewProvider {
    static var previews: some View {
        CreatePlaylistView(createPlaylistVM: CreatePlaylistViewModel())
    }
}
