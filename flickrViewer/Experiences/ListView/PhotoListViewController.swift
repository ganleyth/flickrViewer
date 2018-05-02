//
//  PhotoListViewController.swift
//  flickrViewer
//
//  Created by Thomas Ganley on 4/25/18.
//  Copyright © 2018 Thomas Ganley. All rights reserved.
//

import UIKit

class PhotoListViewController: UIViewController {

    @IBOutlet private var interactor: PhotoListInteractor!
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
    }
}
