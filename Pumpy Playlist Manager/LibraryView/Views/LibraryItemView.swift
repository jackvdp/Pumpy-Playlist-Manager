//
//  LibraryItemView.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import SwiftUI
import CachedAsyncImage

struct LibraryItemView: View {
    
    let libraryPlaylist: LibraryPlaylist
    let itemSize = 150
    
    var body: some View {
        VStack(alignment: .leading) {
            CachedAsyncImage(url: URL(string: libraryPlaylist.artworkURL?.getArtworkURLForSize(itemSize) ?? "")) { image in
                image.resizable()
            } placeholder: {
                Image(K.Images.pumpyArtwork)
                    .resizable()
            }
            .cornerRadius(5)
            .frame(width: CGFloat(itemSize), height: CGFloat(itemSize))
            Text(libraryPlaylist.name)
                .lineLimit(1)
            Text(libraryPlaylist.shortDescription ?? "")
                .lineLimit(2)
                .opacity(0.5)
        }
        .frame(width: CGFloat(itemSize), height: CGFloat(itemSize + 55), alignment: .top)
        .padding()
    }
}

struct LibraryItemView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryItemView(libraryPlaylist: MockData.mockLibraryPlaylist)
    }
}
