//
//  SearchBar.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import SwiftUI

struct SearchBar<ViewModel: SearchViewModel>: View {
    
    @ObservedObject var searchVM: ViewModel
    
    var body: some View {
        HStack {
            ZStack(alignment: .trailing) {
                TextField(
                    searchVM.placeHolderText,
                    text: $searchVM.searchTerm
                )
                    .onSubmit {
                        searchVM.runSearch()
                    }
                if searchVM.searchTerm != "" {
                    Image(systemName: "xmark.circle")
                        .frame(width: 5, height: 5)
                        .opacity(0.5)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            searchVM.searchTerm = ""
                        }
                }
            }
            .textFieldStyle(.roundedBorder)
            Button {
                searchVM.runSearch()
            } label: {
                Image(systemName: "magnifyingglass")
                    .resizable()
            }
            .frame(width: 20, height: 20)
            .foregroundColor(.pumpyPink)
            .buttonStyle(.plain)
        }
        .padding()
        .frame(width: 300)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchVM: PlaylistSearchViewModel())
    }
}
