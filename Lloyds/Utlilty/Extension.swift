//
//  Extension.swift
//  Lloyds
//
//  Created by Venkatesh Badya on 04/07/22.
//

import Foundation
import UIKit

extension UIView {
    
    // Adding border to View
    func addBorder(_ color: CGColor = UIColor.gray.cgColor, _ width: CGFloat = 1.0) {
        self.layer.borderColor = UIColor.gray.cgColor
        self.layer.borderWidth = 1.0
        self.layer.cornerRadius = 10
    }
}
