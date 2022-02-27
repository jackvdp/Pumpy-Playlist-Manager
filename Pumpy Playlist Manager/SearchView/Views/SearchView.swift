//
//  SYBPlaylistView.swift
//  GraphQL Test
//
//  Created by Jack Vanderpump on 10/02/2022.
//

import SwiftUI

struct SearchView: View {
    
    @StateObject var searchVM = PlaylistSearchViewModel()

    var body: some View {
        VStack() {
            ZStack(alignment: .trailing) {
                Header(title: "Search")
                SearchBar(searchVM: searchVM)
            }
            Spacer()
            if let id = searchVM.playlistID {
                GetPlaylistView(getPlaylistVM: GetPlaylistViewModel(id: id))
                Spacer()
            }
        }
        .alert(searchVM.errorMessage.title, isPresented: $searchVM.showError) {
            Button("OK") {}
        } message: {
            Text(searchVM.errorMessage.message)
        }
    }
}

struct SYBPlaylistView_Previews: PreviewProvider {

    static var previews: some View {
        SearchView()
    }
}
