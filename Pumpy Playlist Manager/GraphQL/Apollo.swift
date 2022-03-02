//
//  Apollo.swift
//  GraphQL Test
//
//  Created by Jack Vanderpump on 10/02/2022.
//

import Foundation
import Apollo

class Apollo {
    
    static let shared = Apollo()
    let client: ApolloClient

    init() {
      client = ApolloClient(url: URL(string: "https://api.soundtrackyourbrand.com/v2")!)
    }
}
