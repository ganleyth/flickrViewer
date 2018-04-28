//
//  NetworkController.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 4/27/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

class NetworkController {
    
    static let shared = NetworkController()
    
    lazy var session: SessionProtocol = URLSession.shared
    
    func get(url: URL, with completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let dataTask = session.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }
        
        dataTask.resume()
    }
}


/**
 Adopt for dependency injection
 */
protocol SessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: SessionProtocol {}
