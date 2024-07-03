//
//  APIEndpointProvider.swift
//  NASARovers
//
//  Created by Arsalan on 03.07.2024.
//

import Foundation

// MARK: - Endpoint
enum Endpoint {
    case manifests(rover: Rover)
    case photoForSol(Int, rover: Rover, page: Int)
    case photoForDate(Date, rover: Rover, page: Int)
    case roverPage(rover: Rover)
}

enum Constants: String {
    case fileName = "Config"
    case fileExtension = "plist"
    case apiKey = "apiKey"
    case roverPageURL = "roverPageURL"
    case api = "api"
    case scheme = "scheme"
    case domain = "domain"
    case subDomain = "subDomain"
    case version = "version"
    case manifests = "manifests"
    case rovers = "rovers"
    case photos = "photos"
    case earthDate = "earth_date"
    case page = "page"
    case sol = "sol"
}

final class APIEndpointProvider {
    private let apiKey: String
    private let baseURL: URL
    private let pageURLs: [String: String]
    
    init() {
        var format = PropertyListSerialization.PropertyListFormat.xml
        
        guard let path = Bundle.main.path(forResource: Constants.fileName.rawValue, ofType: Constants.fileExtension.rawValue),
              let data = FileManager.default.contents(atPath: path),
              let config = try? PropertyListSerialization.propertyList(
                from: data,
                options: .mutableContainersAndLeaves,
                format: &format
              ) as? [String: Any] else {
            fatalError("\(Constants.fileName.rawValue).\(Constants.fileExtension.rawValue) not found")
        }
        
        self.apiKey = config[Constants.apiKey.rawValue] as! String
        self.pageURLs = config[Constants.roverPageURL.rawValue] as! [String: String]
        let api = config[Constants.api.rawValue] as! [String: Any]
        
        var urlComponents = URLComponents()
        urlComponents.scheme = api[Constants.scheme.rawValue] as? String
        urlComponents.host = api[Constants.domain.rawValue] as? String
        urlComponents.path = (api[Constants.subDomain.rawValue] as! String) + (api[Constants.version.rawValue] as! String)
     
        guard let saveURL = urlComponents.url else {
            fatalError("Could not unwrap urlComponents.url in \(#function)")
        }
        self.baseURL = saveURL
    }
    
    func getURL(endpoint: Endpoint) -> URL {
        var url = baseURL
        
        switch endpoint {
        case .manifests(let rover):
            url.append(path: "\(Constants.manifests.rawValue)/\(rover.rawValue)")
        case .photoForDate(let date, let rover, let page):
            url.append(path: "\(Constants.rovers.rawValue)/\(rover.rawValue)/\(Constants.photos.rawValue)")
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            
            url.append(queryItems: [
                URLQueryItem(name: Constants.earthDate.rawValue, value: dateFormatter.string(from: date)),
                URLQueryItem(name: Constants.page.rawValue, value: String(page))
            ])
        case .photoForSol(let sol, let rover, let page):
            url.append(path: "\(Constants.rovers.rawValue)/\(rover.rawValue)/\(Constants.photos.rawValue)")
            url.append(queryItems: [
                URLQueryItem(name: Constants.sol.rawValue, value: String(sol)),
                URLQueryItem(name: Constants.page.rawValue, value: String(page))
            ])
        case .roverPage(let rover):
            guard let urlString = pageURLs[rover.rawValue],
                  let roverPageURL = URL(string: urlString) else { return baseURL }
            
            return roverPageURL
        }
        
        url.append(queryItems: [
            URLQueryItem(name: "api_key", value: apiKey)
        ])
        
        return url
    }
}
