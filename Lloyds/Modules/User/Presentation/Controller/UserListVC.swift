//
//  ViewController.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import UIKit

class UserListVC: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variables
    
    var viewModel: IUserViewModel?
        
    // MARK: Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.accessibilityIdentifier = "table--userTableView"
        viewModel?.fetchUsers()
    }
}


