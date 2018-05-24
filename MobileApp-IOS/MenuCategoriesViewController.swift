//
//  MenuCategoriesViewController.swift
//  MobileApp-IOS
//
//  Created by Dmitry Demidov on 19.05.2018.
//  Copyright © 2018 Dmitry Demidov. All rights reserved.
//

import UIKit

extension NSAttributedString {
    func width(withConstrainedHeight height: CGFloat) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, context: nil)
        
        return ceil(boundingBox.width)
    }
}

class MenuCategoriesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate  {

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let firstCategory = IndexPath(row: 0, section: 0)
        categoriesView.selectItem(at: firstCategory, animated: true, scrollPosition: .centeredHorizontally)
        moveSelector(to: firstCategory, withAnimation: false)
    }
    
    //MARK - Model
    var menu : [MenuCategory]?
    //MARK - CategoriesView
    
    
    @IBOutlet weak var categoriesView: UICollectionView! {
        didSet {
            categoriesView.delegate = self
            categoriesView.dataSource = self
            categoriesView.showsHorizontalScrollIndicator = false
        }
    }
    
    @IBOutlet weak var categoriesSelector: UIView! {
        didSet {
            categoriesSelector.isHidden = true
            categoriesSelector.backgroundColor = CategoriesViewConstants.selectedColor
        }
    }
    
    
    private var categoriesFont: UIFont {
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(16.0))
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let indexPaths = categoriesView.indexPathsForSelectedItems, indexPaths.count > 0 {
            let indexPath = indexPaths[0]
            moveSelector(to: indexPath, withAnimation: false)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesViewCell", for: indexPath)
        if let categoryCell = cell as? CategoriesViewCell, let categories = menu {
            categoryCell.label.attributedText = NSAttributedString(string: categories[indexPath.row].name,
                                                                   attributes: [.font: categoriesFont])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.frame.height - 10
        let name = menu?[indexPath.row].name ?? ""
        let width = NSAttributedString(string: name,
                                       attributes: [.font: categoriesFont]).width(withConstrainedHeight: height) +
            CategoriesViewConstants.leadingMargin + CategoriesViewConstants.trailingMargin
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        moveSelector(to: indexPath, withAnimation: true)
    }
    
    private func moveSelector(to indexPath: IndexPath, withAnimation animation: Bool) {
        if let attributes = categoriesView.layoutAttributesForItem(at: indexPath) {
            let frame = categoriesView.convert(attributes.frame, to: categoriesView.superview)
            if animation {
                UIViewPropertyAnimator.runningPropertyAnimator(
                    withDuration: 0.2,
                    delay: 0.0,
                    options: [.allowUserInteraction],
                    animations: {
                        self.categoriesSelector.frame = CGRect(x: frame.minX,
                                                               y: frame.maxY - CategoriesViewConstants.selectorHeight,
                                                               width: frame.width,
                                                               height: CategoriesViewConstants.selectorHeight)
                }) { (position) in
                    if self.categoriesSelector.isHidden {
                        self.categoriesSelector.isHidden = false
                    }
                }
            }
            else
            {
                categoriesSelector.frame = CGRect(x: frame.minX,
                                                  y: frame.maxY - CategoriesViewConstants.selectorHeight,
                                                  width: frame.width,
                                                  height: CategoriesViewConstants.selectorHeight)
                categoriesSelector.isHidden = false
            }
            
        }
    }
}
