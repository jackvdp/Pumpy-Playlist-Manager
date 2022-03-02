//
//  LibraryAPIModel.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 01/03/2022.
//

import Foundation
import FirebaseFirestore
import CodableFirebase

class LibraryAPIModel {
    
    let db = Firestore.firestore()
    
    func downloadPlaylists(username: String, completion: @escaping ([LibraryPlaylist])->()) -> ListenerRegistration {
        let playlistsRef = db.collection(username).document(K.Fire.playlistLibrary)

        return playlistsRef.addSnapshotListener { documentSnapshot, error in
            
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
                    let libraryPlaylists = decodedPlaylists.sorted(by: { $0.name ?? "" < $1.name ?? "" })
                    completion(libraryPlaylists)
                } else {
                    print("Error decoding")
                }
            }
        }
    }
    
    func addPlaylistToLibrary(playlist: LibraryPlaylist) {
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
    
    func removePlaylistFromLibrary(playlist: LibraryPlaylist) {
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
    
}
