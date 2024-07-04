//
//  Manifest.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import Foundation

// MARK: - Manifest
struct Manifest: Codable {
    let photoManifest: PhotoManifest

    enum CodingKeys: String, CodingKey {
        case photoManifest = "photo_manifest"
    }
}

// MARK: - PhotoManifest
struct PhotoManifest: Codable {
    let name, landingDate, launchDate, status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let photos: [Photo]

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

// MARK: - Photo
struct Photo: Codable {
    let sol: Int
    let earthDate: String
    let totalPhotos: Int
    let cameras: [Camera]

    enum CodingKeys: String, CodingKey {
        case sol
        case earthDate = "earth_date"
        case totalPhotos = "total_photos"
        case cameras
    }
}

enum Camera: String, Codable {
    case chemcam = "CHEMCAM"
    case fhaz = "FHAZ"
    case mahli = "MAHLI"
    case mardi = "MARDI"
    case mast = "MAST"
    case navcam = "NAVCAM"
    case rhaz = "RHAZ"
}
