//
//  LearnTrackCache.swift
//  Learn
//
//  Created by Luke Ghenco on 5/5/19.
//  Copyright © 2019 Johann Kerr. All rights reserved.
//
import Foundation

struct LearnTrackCache {
    func get() -> Track? {
        guard let trackUUID = getUserTrackFromDefaults() else { return nil }
        return decodeTrackFromDisk(trackUUID)
    }
    
    func set(_ track: Track, data: Data) {
        cacheTrackUUID(track.uuid)
        let trackPath = self.getDocumentsDirectory().appendingPathComponent(track.uuid)
        try? data.write(to: trackPath)
    }
    
    func remove(_ trackUUID: String) {
        let trackPath = self.getDocumentsDirectory().appendingPathComponent(trackUUID)
        try? FileManager.default.removeItem(at: trackPath)
    }
    
    private func cacheTrackUUID(_ trackUUID: String) {
        UserDefaults.standard.set(trackUUID, forKey: "trackUUID")
    }
    
    private func decodeTrackFromDisk(_ trackUUID: String) -> Track? {
        let trackPath = self.getDocumentsDirectory().appendingPathComponent(trackUUID)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        
        do {
            let stringData = try String(contentsOf: trackPath)
            let track = try decoder.decode(Track.self, from: Data(stringData.utf8))
            return track
        } catch {
            return nil
        }
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    private func getUserTrackFromDefaults() -> String? {
        return UserDefaults.standard.string(forKey: "trackUUID")
    }
}
