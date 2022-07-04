//
//  UserListVC+Extensions.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation
import UIKit

extension UserListVC: CallbackStatus {
    
    func success() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func failure(_ message: String) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: NSLocalizedString("alert", comment: ""), message: message, preferredStyle: .alert)
            alert.addAction( UIAlertAction(title: NSLocalizedString("ok", comment: ""), style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
}
