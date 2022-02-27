//
//  LoginView.swift
//  GraphQL Test
//
//  Created by Jack Vanderpump on 10/02/2022.
//

import SwiftUI

struct LoginView: View {
    
    @EnvironmentObject var accountManager: AccountManager
    
    var body: some View {
        VStack {
            Header(title: "Accounts")
            Spacer()
            VStack(spacing: 20) {
                VStack {
                    Text("SoundTrackYourBrand")
                        .font(.title)
                    if accountManager.sybLoggedIn {
                        LoggedInView(username: accountManager.sybUsername, signOutFunction: accountManager.sybSignOut)
                    } else {
                        LoginViewRow(
                            username: $accountManager.sybUsername,
                            password: $accountManager.sybPassword,
                            isLoggingIn: $accountManager.sybLoggingIn,
                            loginMethod: accountManager.sybLogin)
                    }
                }
                VStack {
                    Text("Pumpy Account")
                        .font(.title)
                    if accountManager.fireLoggedIn {
                        LoggedInView(username: accountManager.fireUsername, signOutFunction: accountManager.fireSignOut)
                    } else {
                        LoginViewRow(
                            username: $accountManager.fireUsername,
                            password: $accountManager.firePassword,
                            isLoggingIn: $accountManager.fireLoggingIn,
                            loginMethod: accountManager.fireSignIn
                        )
                    }
                }
            }
            .listStyle(.plain)
            .padding()
            .frame(maxWidth: 600)
            Spacer()
        }
        
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .environmentObject(AccountManager())
    }
}
