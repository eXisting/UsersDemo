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
        loadUsers()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.users == nil {
            return 0
        }
        
        return self.users!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UserCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! UserCell
        
        if self.users != nil && self.users!.count >= indexPath.row {
            let user = self.users![indexPath.row]
            
            cell.fullName.text = user.name! + " " + user.surname!
            cell.phone.text = user.phone!
            
            cell.photo.roundImageBy(divider: 2.0)
            cell.photo.image = user.image
        }
        
        return cell        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let user = sender as? RemoteUser
        if let navigation  = segue.destination as? UINavigationController {
            if let p_Controller = navigation.topViewController as? ProfileViewController {
                p_Controller.userInfo = user
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetail", sender: self.users![indexPath.row])
    }
    
    // MARK: Functions
    
    private func customizeTableView() {
        self.tableView.backgroundColor = UIColor.white
    }
    
    private func loadUsers() {
        self.users = persistenceManager.fetch(SavedUser.self)
        
        // TODO: convert binary data into images
        
        self.tableView?.reloadData()
    }
    
}

