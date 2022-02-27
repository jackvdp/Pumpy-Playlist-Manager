//
//  LibraryGridView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 17/02/2022.
//

import SwiftUI

struct LibraryGridView: View {
    
    @EnvironmentObject var libraryManager: LibraryManager
    @ObservedObject var libraryVM: LibraryViewModel
    @State var itemSelected: LibraryPlaylist?
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(libraryManager.libraryPlaylists, id: \.self) { playlist in
                    LibraryItemView(libraryPlaylist: playlist)
                        .buttonStyle(.plain)
                        .gesture(TapGesture(count: 2).onEnded {
                            libraryVM.playlistSelected = playlist
                        })
                        .simultaneousGesture(TapGesture().onEnded {
                            itemSelected = playlist
                        })
                        .background(
                            Rectangle()
                                .foregroundColor(itemSelected == playlist ? .pumpyPink : .clear)
                                .cornerRadius(20)
                        )
                }
            }
            .padding(.horizontal)
        }
        .onTapGesture {
            itemSelected = nil
        }
    }
}

struct LibraryGridView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryGridView(libraryVM: LibraryViewModel())
    }
}
