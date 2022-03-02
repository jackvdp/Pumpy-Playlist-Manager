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
    
    let columns = [
        GridItem(.adaptive(minimum: 180))
    ]
    
    var body: some View {
        if libraryManager.libraryPlaylists.isEmpty {
            Text("No playlists saved")
                .font(.title)
        } else {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(libraryManager.libraryPlaylists, id: \.self) { playlist in
                        LibraryItemView(playlist: playlist,
                                        libraryVM: libraryVM,
                                        itemSelected: $libraryVM.itemsSelected)
                            .gesture(TapGesture(count: 2).onEnded {
                                libraryVM.goToPlaylistView()
                            })
                            .simultaneousGesture(TapGesture().onEnded {
                                libraryVM.toggleSelectItem(playlist: playlist)
                            })
                            .background(
                                Rectangle()
                                    .foregroundColor(libraryVM.itemsSelected.contains(playlist) ? .pumpyPink : .clear)
                                    .cornerRadius(20)
                            )
                    }
                }
                .padding(.horizontal)
            }
            .onTapGesture {
                libraryVM.unSelectAllItems()
            }
        }
        
    }
}

struct LibraryGridView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryGridView(libraryVM: LibraryViewModel(mode: .library))
    }
}
