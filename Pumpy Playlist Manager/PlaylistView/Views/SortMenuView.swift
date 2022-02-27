//
//  SortMenuView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 18/02/2022.
//

import SwiftUI

struct SortMenuView: View {
    
    @ObservedObject var playlistVM: PlaylistViewModel
    
    var body: some View {
        Picker("Sort by:", selection: $playlistVM.sortBy) {
            ForEach(SortTracks.allCases) { sortBy in
                Text(sortBy.rawValue)
            }
        }
        .pickerStyle(.menu)
        .frame(width: 250)
    }
}

struct SortMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SortMenuView(playlistVM: PlaylistViewModel(MockData.mockPlaylist))
    }
}
