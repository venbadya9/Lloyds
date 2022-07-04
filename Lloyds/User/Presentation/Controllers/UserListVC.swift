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
        initialConfiguration()
    }
    
    // MARK: Methods
    
    // Configuring view model
    func initialConfiguration() {
        
        let service = NetworkClient()
        let repository = UserRepositoryImpl(service: service)
        let useCase = UserUseCaseImpl(repository: repository)
        viewModel = UserViewModelImpl(useCase: useCase)
        viewModel?.output = self
        viewModel?.fetchUsers()
    }
}


