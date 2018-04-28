//
//  Photo.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 4/25/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

/**
 The top level response object for a photo search.
 */
struct SearchResponse: Decodable {
    fileprivate let photosAndMeta: PhotosAndMeta
    
    var photos: [Photo] {
        return photosAndMeta.photos
    }
    
    enum CodingKeys: String, CodingKey {
        case photosAndMeta = "photos"
    }
}

fileprivate extension SearchResponse {
    struct PhotosAndMeta: Decodable {
        let photos: [Photo]
        
        enum CodingKeys: String, CodingKey {
            case photos = "photo"
        }
    }
}

/**
 Contains the description of a search result photo and all info needed to construct image URL
 */
struct Photo: Decodable {
    let id: String
    let title: String
    let farmID: Int
    let serverID: String
    let secret: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case farmID = "farm"
        case serverID = "server"
        case secret
    }
}

extension Photo: Equatable {
    static func ==(lhs: Photo, rhs: Photo) -> Bool {
        if lhs.id != rhs.id { return false }
        if lhs.title != rhs.title { return false }
        if lhs.farmID != rhs.farmID { return false }
        if lhs.serverID != rhs.serverID { return false }
        if lhs.secret != rhs.secret { return false }
        
        return true
    }
}
