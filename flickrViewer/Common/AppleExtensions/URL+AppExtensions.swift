//
//  URL+AppExtensions.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 5/1/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

extension URL {
    
    /**
     Add any number of URL parameters to a base URL. Returns base URL if the composition fails.
     */
    func appendingParameters(_ params: [String: String]) -> URL {
        guard var components = URLComponents(url: self, resolvingAgainstBaseURL: false) else { return self }
        let queryItems = params.map { URLQueryItem(name: $0.key, value: $0.value) }
        components.queryItems = queryItems
        
        return components.url ?? self
    }
}
