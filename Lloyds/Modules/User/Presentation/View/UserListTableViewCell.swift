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
    
    // Using UserCellViewModel for configuring cell
    var userCellModel : UserCellViewModel? {
        didSet {
            userImageView?.sd_setImage(with: URL( string: userCellModel?.avatar ?? "" ), completed: nil)
            if let firstName = userCellModel?.firstName,
               let lastName = userCellModel?.lastName {
                nameLabel.text = firstName + " " + lastName
            }
            emailLabel.text = userCellModel?.email
        }
    }
    
    // MARK: Object Lifecycle
    
    override func awakeFromNib() {
        self.bgView.addBorder()
    }
}
