//
//  SavedUsersViewController.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/23/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class SavedUsersViewController: UITableViewController {
    
    // MARK: FIelds
    
    private var persistenceManager: PersistenceManager
    
    private var users: [UserProtocol]?
    
    // MARK: Outlets
    
    // MARK: Overrides
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        persistenceManager = PersistenceManager.instance
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        persistenceManager = PersistenceManager.instance
        super.init(coder: aDecoder)
    }
    
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
        let fetchedUsers = persistenceManager.fetch(SavedUser.self)
        
        fetchedUsers.forEach({ user in self.users?.append(user) })
        // TODO: convert binary data into images
    }
}

