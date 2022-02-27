//
//  SYBAccount.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import Foundation
import Apollo

extension AccountManager {
    
    func sybAutoSignIn() {
        if let username = UserDefaults.standard.string(forKey: K.KeychainKeys.sybUsernameKey) {
            self.sybUsername = username
            if let password = UserDefaults.standard.string(forKey: K.KeychainKeys.sybPasswordKey) {
                self.sybPassword = password
                sybLogin()
            }
        }
    }
    
    func sybLogin() {
        if !sybLoggingIn {
            sybLoggingIn = true
            let loginMutation = LoginMutation(email: sybUsername, password: sybPassword)
            
            Apollo.shared.client.perform(mutation: loginMutation) { result in
                self.sybLoggingIn = false
                switch result {
                case .success(let result):
                    print("Got data")
                    self.dealWithSYBLogIn(result)
                case .failure(let error):
                    print("Error loading data \(error)")
                }
            }
        }
    }
    
    func dealWithSYBLogIn(_ result: GraphQLResult<LoginMutation.Data>) {
        if let token = result.data?.loginUser?.token {
            sybToken = token
            UserDefaults.standard.set(token, forKey: K.KeychainKeys.sybTokenKey)
            UserDefaults.standard.set(sybUsername, forKey: K.KeychainKeys.sybUsernameKey)
            UserDefaults.standard.set(sybPassword, forKey: K.KeychainKeys.sybPasswordKey)
            sybLoggedIn = true
        }
    }
    
    func sybSignOut() {
        sybToken = ""
        sybPassword = ""
        UserDefaults.standard.set("", forKey: K.KeychainKeys.sybPasswordKey)
        sybLoggedIn = false
    }
    
}
