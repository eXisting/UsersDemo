//
//  SavedUsersViewController.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/23/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class SavedUsersViewController: UITableViewController {
    
    // MARK: Outlets
    
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeTableView()
        populateUsers()
    }
    
    // MARK: Functions
    
    private func customizeTableView() {
        self.tableView.backgroundColor = UIColor.white
    }
    
    private func populateUsers() {
        // TODO: Call API and fill table view
    }
    
    
}

