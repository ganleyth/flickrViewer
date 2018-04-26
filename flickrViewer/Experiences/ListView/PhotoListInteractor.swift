//
//  PhotoListInteractor.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 4/25/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class PhotoListInteractor: NSObject {
    
    @IBOutlet weak var viewController: PhotoListViewController!
}

// MARK: - Table view data source
extension PhotoListInteractor: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
