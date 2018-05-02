//
//  PhotoListInteractor.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 4/25/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class PhotoListInteractor: NSObject {
    
    @IBOutlet weak var photoListViewController: PhotoListViewController!
    private var photos: [Photo] = []
    private var page: Int = 0
    private var currentSearchTerm: String?
    
    private lazy var tableBackgroundView: UIView = {
        let view = UIView(frame: photoListViewController.tableView.frame)
        view.backgroundColor = .white
        let label = UILabel()
        view.addSubview(label)
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Begin your flickr search by searching for specific keywords"
        label.textAlignment = .center
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.4)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        label.topAnchor.constraint(equalTo: view.topAnchor, constant: 60).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        view.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 32).isActive = true
        return view
    }()
}

// MARK: - Table view data source
extension PhotoListInteractor: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoListViewController.tableView.backgroundView = photos.isEmpty ? tableBackgroundView : nil
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "thumbnailCell", for: indexPath) as? PhotoTableViewCell else {
            assertionFailure("Could not dequeue a reusable photo table view cell.")
            return PhotoTableViewCell()
        }
        let photo = photos[indexPath.row]
        cell.configure(with: photo)
        
        return cell
    }
}

// MARK: - Table view delegate
extension PhotoListInteractor: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        // increment the page when the user views the 25th cell of the current page
        if indexPath.row == page * 25 + 24 {
            page += 1
            search()
        }
    }
}

// MARK: - Search bar delegate
extension PhotoListInteractor: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        currentSearchTerm = searchBar.text
        page = 0
        search()
    }
}

// MARK: - Private
private extension PhotoListInteractor {
    
    func search() {
        guard let searchTerm = currentSearchTerm, !searchTerm.isEmpty else { return }
        SearchController.search(searchTerm: searchTerm, page: page) { [weak self] (photos) in
            guard let this = self else { return }
            
            guard let photos = photos, !photos.isEmpty else {
                let title = "No Results Found"
                let message = "Could not find results for that search term. Please try again."
                this.photoListViewController.presentBasicInfoAlertWith(title: title, message: message)
                return
            }
            
            if this.page == 0 {
                this.photos = photos
            } else {
                this.photos += photos
            }
            this.photoListViewController.tableView.reloadData()
            if this.page == 0 {
                this.photoListViewController.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: false)
            }
        }
    }
}
