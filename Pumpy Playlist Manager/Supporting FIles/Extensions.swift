//
//  Extensions.swift
//  Pumpy Playlist Manager
//
//  Created by Jack Vanderpump on 12/02/2022.
//

import Foundation
import SwiftUI
import AVFoundation
import ActivityIndicatorView

extension Color {
    static let pumpyPink = Color("pumpyPink")
    static let pumpyPinkDark = Color("pumpyPink-dark")
}

extension String {
    func getArtworkURLForSize(_ size: Int) -> String {
        self.replacingOccurrences(of: "%w", with: String(size)).replacingOccurrences(of: "%h", with: String(size))
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

struct AppActivityIndicatorView: View {
    
    @Binding var isVisible: Bool
    
    var body: some View {
        ActivityIndicatorView(isVisible: $isVisible, type: .arcs)
            .frame(width: 25, height: 25)
            .foregroundColor(.pumpyPink)
    }
    
}

extension Array where Element == Track {
    func removingDuplicates() -> [Track] {
        var addedDict = [String: Track]()
        
        return filter {
            addedDict.updateValue($0, forKey: $0.isrc) == nil
        }
    }
}

extension String {
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
}

extension Array {
    func chunks(_ chunkSize: Int) -> [[Element]] {
        return stride(from: 0, to: self.count, by: chunkSize).map {
            Array(self[$0..<Swift.min($0 + chunkSize, self.count)])
        }
    }
}
