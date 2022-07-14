//
//  ViewController.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 13/07/22.
//

import UIKit

class UserListVC: UIViewController {
    
    // MARK: IBOutlets

    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: Variables
    
    var viewModel: IUserViewModel?
        
    // MARK: Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.accessibilityIdentifier = "table--userTableView"
        viewModel?.fetchUsers()
    }
}

extension UserListVC: CallbackStatus {
    
    func handleSuccess() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func handleFailure(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("alert", comment: ""), message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}



