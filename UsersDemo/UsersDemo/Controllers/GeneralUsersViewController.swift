//
//  GeneralUsersViewController.swift
//  UsersDemo
//
//  Created by Andrey Popazov on 10/23/18.
//  Copyright © 2018 Andrey Popazov. All rights reserved.
//

import UIKit

class GeneralUsersViewController: UITableViewController {
    
    // MARK: Fields
    
    private var usersWrapper: UsersWrapper?
    private var users: [UserProtocol]?
    private var isLoadingUsers = false
        
    // MARK: Overrides
    
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

            let rowsToLoadFromBottom = 5;
            let rowsLoaded = self.users!.count
            if (!self.isLoadingUsers && (indexPath.row >= (rowsLoaded - rowsToLoadFromBottom))) {
                let totalRows = self.usersWrapper!.count!
                let remainingToLoad = totalRows - rowsLoaded;
                if (remainingToLoad > 0) {
                    self.loadMore()
                }
            }
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
        isLoadingUsers = true
        
        RequestHandler.loadUsers() { result in
            if let error = result.error {
                self.isLoadingUsers = false
                
                let alert = AlertManager.CreateAlert(
                    title: "Error",
                    message: "Could not load first users :( \(error.localizedDescription)",
                    style: UIAlertController.Style.alert
                )
                
                self.present(alert, animated: true, completion: nil)
            }
            
            let usersWrapper = result.value
            self.addUsersFromWrapper(usersWrapper)
            
            self.reloadTableView()
        }
    }
    
    private func loadMore() {
        self.isLoadingUsers = true
        
        if let users = self.users, let wrapper = self.usersWrapper, let totalUsersCount = wrapper.count, users.count < totalUsersCount {
            RequestHandler.loadMore(usersWrapper) { result in
                if let error = result.error {
                    self.isLoadingUsers = false
                    
                    let alert = AlertManager.CreateAlert(
                        title: "Error",
                        message: "Could not load more users :( \(error.localizedDescription)",
                        style: UIAlertController.Style.alert
                    )
                    
                    self.present(alert, animated: true, completion: nil)
                }
                
                let moreWrapper = result.value
                self.addUsersFromWrapper(moreWrapper)
                
                self.reloadTableView()
            }
        }
    }
    
    private func addUsersFromWrapper(_ wrapper: UsersWrapper?) {
        self.usersWrapper = wrapper
        
        if self.users == nil {
            self.users = self.usersWrapper?.users
        } else if self.usersWrapper != nil && self.usersWrapper!.users != nil {
            self.users = self.users! + self.usersWrapper!.users!
        }
    }
    
    private func reloadTableView() {
        self.isLoadingUsers = false
        self.tableView?.reloadData()
    }
    
}
