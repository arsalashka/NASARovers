//
//  Manifest.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import Foundation

// MARK: - ManifestResponse
struct ManifestResponse: Codable {
    let photoManifest: Manifest
    
    enum CodingKeys: String, CodingKey {
        case photoManifest = "photo_manifest"
    }
}

// MARK: - Manifest
struct Manifest: Codable {
    let name, landingDate, launchDate, status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let photos: [ManifestPhoto]
    
    var sortedPhotos: [ManifestPhoto] {
        photos.reversed()
    }
    
    var rover: Rover {
        Rover(rawValue: name.lowercased()) ?? .opportunity
    }
    
    enum CodingKeys: String, CodingKey {
        case name
        case landingDate = "landing_date"
        case launchDate = "launch_date"
        case status
        case maxSol = "max_sol"
        case maxDate = "max_date"
        case totalPhotos = "total_photos"
        case photos
    }
}

// MARK: - ManifestPhoto
struct ManifestPhoto: Codable {
    let sol: Int
    let earthDate: String
    let totalPhotos: Int
    let cameras: [String]
    
    var pagesCount: Int {
        let photoOnPageCount = 25
        var pages = totalPhotos / photoOnPageCount
        pages += totalPhotos % photoOnPageCount == 0 ? 0 : 1
        return pages
    }
    
    enum CodingKeys: String, CodingKey {
        case sol
        case earthDate = "earth_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}
