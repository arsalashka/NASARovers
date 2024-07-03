//
//  Manifest.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import Foundation

struct Manifest {
    let photoManifest: PhotoManifest
    
    enum CodingKeys: String, CodingKey {
        case photoManifest = "photo_manifest"
    }
}

// MARK: - PhotoManifest
struct PhotoManifest {
    let name, landingDate, launchDate, status: String
    let maxSol: Int
    let maxDate: String
    let totalPhotos: Int
    let photos: [Photo]
}

// MARK: - Photo
struct Photo {
    let sol: Int
    let earthDate: String
    let totalPhotos: Int
    let cameras: [Camera]
}

enum Camera {
    case chemcam
    case fhaz
    case mahli
    case mardi
    case mast
    case navcam
    case rhaz
}
