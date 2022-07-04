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
    lazy var viewModel: UserListViewModel = {
        return UserListViewModel()
    }()
    
    private(set) var onViewLoadedCalled = false
    
    // MARK: Object Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        onViewLoadedCalled = true
        configureViewModel()
    }
    
    // MARK: Methods
    
    // Configuring view model
    func configureViewModel() {
    

        viewModel.showAlertClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let message = self?.viewModel.alertMessage {
                    self?.showAlert( message )
                }
            }
        }
        
        viewModel.reloadTableViewClosure = { [weak self] () in
            DispatchQueue.main.async {
                if let _ = self?.tableView {
                    self?.tableView.reloadData()
                }
            }
        }
        
        viewModel.fetchUserList()
    }
    
    func showAlert( _ message: String ) {
        
        let alert = UIAlertController(title: NSLocalizedString("alert", comment: ""), message: message, preferredStyle: .alert)
        alert.addAction( UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}


