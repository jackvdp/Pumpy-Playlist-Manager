//
//  FireAccount.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import Foundation
import Firebase

extension AccountManager {
    
    func fireAutoSignIn() {
        if let username = UserDefaults.standard.string(forKey: K.KeychainKeys.fireUserKey) {
            self.fireUsername = username
            if let password = UserDefaults.standard.string(forKey: K.KeychainKeys.firePassKey) {
                self.firePassword = password
                fireSignIn()
            }
        }
    }
    
    func fireSignIn() {
        if !fireLoggingIn {
            fireLoggingIn = true
            Auth.auth().signIn(withEmail: fireUsername, password: firePassword) { result, error in
                self.fireLoggingIn = false
                
                guard error == nil else {
                    print(error.debugDescription)
                    return
                }
                if let r = result {
                    self.dealWithFireLogIn(r)
                }
            }
        }
    }
    
    func dealWithFireLogIn(_ result: AuthDataResult) {
        UserDefaults.standard.set(fireUsername, forKey: K.KeychainKeys.fireUserKey)
        UserDefaults.standard.set(firePassword, forKey: K.KeychainKeys.firePassKey)
        fireLoggedIn = true
    }
    
    func fireSignOut() {
        do {
            try Auth.auth().signOut()
            UserDefaults.standard.set("", forKey: K.KeychainKeys.firePassKey)
            firePassword = ""
            fireLoggedIn = false
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
    
}
