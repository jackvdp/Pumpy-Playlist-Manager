//
//  AccountManager.swift
//  GraphQL Test
//
//  Created by Jack Vanderpump on 10/02/2022.
//

import Foundation
import SwiftUI
import Apollo
import SwiftKeychainWrapper

class AccountManager: ObservableObject {
    
    @Published var sybUsername = String()
    @Published var sybPassword = String()
    @Published var sybToken: String?
    @Published var sybLoggedIn = false
    @Published var sybLoggingIn = false
    
    @Published var fireUsername = String()
    @Published var firePassword = String()
    @Published var fireLoggedIn = false
    @Published var fireLoggingIn = false
    
    init() {
        sybAutoSignIn()
        fireAutoSignIn()
    }
    
}
