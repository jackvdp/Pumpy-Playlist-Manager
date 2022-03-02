//
//  Header.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 16/02/2022.
//

import SwiftUI

struct Header: View {
    let title: String
    var backFunction: (() -> ())?
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                if let function = backFunction {
                    Button {
                        function()
                    } label: {
                        Image(systemName: "arrow.left")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.pumpyPink)
                    }
                    .buttonStyle(.plain)
                    .padding(.trailing)
                }
                Text(title)
                    .font(.largeTitle)
                    .fontWeight(.bold)
            }
            Divider()
        }
        .padding([.top, .horizontal])
    }
}

struct Header_Previews: PreviewProvider {
    static var previews: some View {
        Header(title: "Home")
    }
}
