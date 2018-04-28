//
//  NetworkController.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 4/27/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import Foundation

class NetworkController {

    static func get(url: URL, with completion: @escaping (_ data: Data?, _ error: Error?) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, error) in
            completion(data, error)
        }
        
        dataTask.resume()
    }
}
