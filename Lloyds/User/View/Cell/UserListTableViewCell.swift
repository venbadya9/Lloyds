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
    
    // Cell Model
    var userCellViewModel : UserCellViewModel? {
        didSet {
            userImageView?.sd_setImage(with: URL( string: userCellViewModel?.avatar ?? "" ), completed: nil)
            if let firstName = userCellViewModel?.firstName,
               let lastName = userCellViewModel?.lastName {
                nameLabel.text = firstName + " " + lastName
            }
            emailLabel.text = userCellViewModel?.email
        }
    }
    
    // MARK: Object Lifecycle
    
    override func awakeFromNib() {
        self.bgView.addBorder()
    }
}
