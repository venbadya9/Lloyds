//
//  ViewController.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 30/06/22.
//

import UIKit

class UserListVC: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    
    var viewModel: UserViewModel?
        
    // MARK: Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.accessibilityIdentifier = "table-Users"
        viewModel?.fetchUsers()
    }
}


