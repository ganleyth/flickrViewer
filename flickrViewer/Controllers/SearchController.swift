//
//  SearchController.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 5/1/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

class SearchController {
    
    static func search(searchTerm: String, page: Int, completion: @escaping (_ photos: [Photo]?) -> Void) {
        guard let endPoint = buildURLFor(searchTerm: searchTerm, page: page) else {
            assertionFailure("Could not create endpoint URL from constant.")
            completion(nil)
            return
        }
        
        NetworkController.get(url: endPoint) { (data, error) in
            var photos: [Photo]? = nil
            defer {
                DispatchQueue.main.async {
                    completion(photos)
                }
            }
            
            if let error = error { print("Error fetching photo objects: \(error.localizedDescription)"); return }
            guard let data = data else { print("Returned data is nil."); return }
            
            do {
                let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                photos = searchResponse.photos
            } catch {
                print("Could not decode search response: \(error.localizedDescription)")
                return
            }
        }
    }
    
    static func buildURLFor(searchTerm: String, page: Int) -> URL? {
        guard let endPoint = URL(string: Constants.FlickrAPI.endpointURLString) else { return nil }
        
        let params: [String: String] = [
            Constants.FlickrAPI.apiKeyKey: Constants.FlickrAPI.apiKey,
            Constants.FlickrAPI.textKey: searchTerm,
            Constants.FlickrAPI.pageKey: "\(page)",
            Constants.FlickrAPI.perPageKey: "25"
        ]
        
        return endPoint.appendingParameters(params)
    }
}
