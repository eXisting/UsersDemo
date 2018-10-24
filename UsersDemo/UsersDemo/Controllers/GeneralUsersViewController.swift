//
//  GeneralUsersViewController.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/23/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class GeneralUsersViewController: UITableViewController {
    
    // MARK: Outlets
        
    // MARK: Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeTableView()
        populateUsers()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    // MARK: Functions
    
    private func customizeTableView() {
        self.tableView.backgroundColor = UIColor.white
    }
    
    private func populateUsers() {
        // TODO: Call API and fill table view
        
        let users : [User] = RequestHandler.getUsers()
        
        print(users)
    }
    
}
