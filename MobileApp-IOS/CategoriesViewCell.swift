//
//  CategoriesViewCell.swift
//  MobileApp-IOS
//
//  Created by Dmitry Demidov on 18.05.2018.
//  Copyright © 2018 Dmitry Demidov. All rights reserved.
//

import UIKit

struct CategoriesViewConstants {
    static let leadingMargin = CGFloat(integerLiteral: 8)
    static let trailingMargin = CGFloat(integerLiteral: 8)
    static let selectedColor = UIColor(red: 1.0, green: 1.0, blue: 0.0, alpha: 1.0)
    static let selectorHeight = CGFloat(integerLiteral: 4)
    static let labelForegroundColor = UIColor(red: 204.0/255.0, green: 204.0/255.0, blue: 204.0/255.0, alpha: 1.0)
}

class CategoriesViewCell: UICollectionViewCell {
    
    @IBOutlet weak var leadingMargin: NSLayoutConstraint! {
        didSet {
            leadingMargin.constant = CategoriesViewConstants.leadingMargin
        }
    }
    @IBOutlet weak var trailingMargin: NSLayoutConstraint! {
        didSet {
            trailingMargin.constant = CategoriesViewConstants.trailingMargin
        }
    }
    @IBOutlet weak var label: UILabel! {
        didSet {
            label.textColor = CategoriesViewConstants.labelForegroundColor
        }
    }
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected {
                label.textColor = CategoriesViewConstants.selectedColor
            } else {
                label.textColor = CategoriesViewConstants.labelForegroundColor
            }
        }
    }
}
