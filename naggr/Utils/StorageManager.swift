//
//  StorageHelper.swift
//  naggr
//
//  Created by Jonathan Moallem on 8/7/18.
//  Copyright © 2018 naggr. All rights reserved.
//

import Foundation

struct StorageManager {
    
    // Fields
    let nagsArchive: URL
    
    init() {
        // Set up the archive URLs
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        nagsArchive = documentsDirectory.appendingPathComponent("nags")
            .appendingPathExtension("json")
    }
    
    func save(nags: [Nag]) throws {
        // Encode and write the data
        let data = try JSONEncoder().encode(nags)
        try write(data, to: nagsArchive)
    }
    
    func loadNags() throws -> [Nag] {
        // Read and decode the data
        let data = try read(from: nagsArchive)
        if let nags = try? JSONDecoder().decode([Nag].self, from: data) {
            return nags
        }
        throw DataAccessError.valueNotRecognised
    }
    
    func read(from archive: URL) throws -> Data {
        // Attempt to read the data
        if let data = try? Data(contentsOf: archive) {
            return data
        }
        throw DataAccessError.valueNotFound
    }
    
    func write(_ data: Data, to archive: URL) throws {
        // Attempt to write the data
        do {
            try data.write(to: archive, options: .noFileProtection)
        }
        catch {
            throw DataAccessError.valueNotSaved
        }
    }
}

// An enum of storage manager errors
enum DataAccessError: Error {
    case valueNotFound
    case valueNotSaved
    case valueNotRecognised
}
