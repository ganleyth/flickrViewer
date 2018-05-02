//
//  UIImageView+AppExtensions.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 4/27/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(at url: URL) {
        self.image = #imageLiteral(resourceName: "defaultPhoto")
        
        NetworkController.get(url: url) { [weak self] (data, error) in
            guard let this = self else { return }
            if let error = error {
                print("Error fetching image: \(error.localizedDescription)")
                return
            }
            
            guard
                let data = data,
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                this.image = image
            }
        }
    }
}
