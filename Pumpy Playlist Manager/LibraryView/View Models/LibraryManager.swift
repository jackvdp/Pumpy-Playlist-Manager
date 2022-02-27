//
//  LibraryManager.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 15/02/2022.
//

import Foundation
import Firebase
import CodableFirebase

class LibraryManager: ObservableObject {
    
    @Published var libraryPlaylists = [LibraryPlaylist]()
    let db = Firestore.firestore()
    var listener: ListenerRegistration?
    
    init() {
        downloadPlaylists()
    }
    
    deinit {
        listener?.remove()
    }
    
    func downloadPlaylists() {
        
        if let username = UserDefaults.standard.string(forKey: K.KeychainKeys.fireUserKey) {
            let playlistsRef = db.collection(username).document(K.Fire.playlistLibrary)

            listener = playlistsRef.addSnapshotListener { documentSnapshot, error in
                
                guard let document = documentSnapshot else {
                    print("Error fetching document: \(error!)")
                    return
                }
                guard let data = document.data() else {
                    print("Document data was empty.")
                    return
                }

                if let dataField = data[K.Fire.playlists] {
                    if let decodedPlaylists = try? FirebaseDecoder().decode([LibraryPlaylist].self, from: dataField) {
                        self.libraryPlaylists = decodedPlaylists.sorted(by: { $0.name < $1.name })
                    } else {
                        print("Error decoding")
                    }
                }
            }
        }
    }
    
    private func addPlaylistToLibrary(playlist: LibraryPlaylist) {
        if let username = UserDefaults.standard.string(forKey: K.KeychainKeys.fireUserKey) {
            let playlistsRef = db.collection(username).document(K.Fire.playlistLibrary)

            let dataPlaylist = try! FirestoreEncoder().encode(playlist)

            playlistsRef.updateData([
                K.Fire.playlists: FieldValue.arrayUnion([dataPlaylist])
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Playlist successfully added!")
                }
            }

        }
    }
    
    private func removePlaylistFromLibrary(playlist: LibraryPlaylist) {
        if let username = UserDefaults.standard.string(forKey: K.KeychainKeys.fireUserKey) {
            let playlistsRef = db.collection(username).document(K.Fire.playlistLibrary)

            let dataPlaylist = try! FirestoreEncoder().encode(playlist)
            
            playlistsRef.updateData([
                K.Fire.playlists: FieldValue.arrayRemove([dataPlaylist])
            ]) { err in
                if let err = err {
                    print("Error writing document: \(err)")
                } else {
                    print("Playlist successfully removed!")
                }
            }
        }
    }
    
    func addRemovePlaylistFromLibrary(_ playlist: LibraryPlaylist) {
        if libraryPlaylists.contains(playlist) {
            removePlaylistFromLibrary(playlist: playlist)
        } else {
            addPlaylistToLibrary(playlist: playlist)
        }
    }
    
    func isInLibrary(_ playlist: LibraryPlaylist) -> Bool {
        libraryPlaylists.contains(playlist)
    }
    
    
} 
