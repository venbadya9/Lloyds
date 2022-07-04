//
//  UserListTableViewCell.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import UIKit
import SDWebImage

class UserListTableViewCell: UITableViewCell {
    
    //MARK: IBOutlets
    
    @IBOutlet weak var bgView: UIView!
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    
    // MARK: Variables
    
    // Using usermodel for configuring cell
    var userModel : User? {
        didSet {
            userImageView?.sd_setImage(with: URL( string: userModel?.avatar ?? "" ), completed: nil)
            if let firstName = userModel?.firstName,
               let lastName = userModel?.lastName {
                nameLabel.text = firstName + " " + lastName
            }
            emailLabel.text = userModel?.email
        }
    }
    
    // MARK: Object Lifecycle
    
    override func awakeFromNib() {
        self.bgView.addBorder()
    }
}
