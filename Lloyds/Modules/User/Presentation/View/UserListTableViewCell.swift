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
    
    @IBOutlet private weak var bgView: UIView!
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    
    // MARK: Variables
    
    // Using UserCellViewModel for configuring cell
    var userCellModel : UserCellViewModel? {
        didSet {
            userImageView?.sd_setImage(with: URL( string: userCellModel?.avatar ?? "" ), completed: nil)
            nameLabel.text = userCellModel?.fullName
            emailLabel.text = userCellModel?.email
        }
    }
    
    // MARK: Object Lifecycle
    
    override func awakeFromNib() {
        self.bgView.addBorder()
    }
}
