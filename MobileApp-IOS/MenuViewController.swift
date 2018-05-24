//
//  FirstViewController.swift
//  MobileApp-IOS
//
//  Created by Dmitry Demidov on 17.05.2018.
//  Copyright © 2018 Dmitry Demidov. All rights reserved.
//

import UIKit

func buildDishes() -> [Dish] {
    var dishes  = [Dish]()
    dishes.append(
        Dish(name: "Салат из кальмара с сыром",
             price: 390,
             imageName: "06760267372997147410",
             description: ""))
    dishes.append(
        Dish(name: "Салат \"Греческий\"",
             price: 400,
             imageName: "14221544169034130393",
             description: "")
    )
    dishes.append(
        Dish(name: "Салат \"Цезарь\"",
             price: 500,
             imageName: "10467152102096263211",
             description: "")
    )
    dishes.append(
        Dish(name: "Салат из авокадо и сёмги",
             price: 690,
             imageName: "04178760770462131904",
             description: "")
    )
    
    return dishes
}

struct DishesViewConstant {
    static let sectionHeight = CGFloat(30)
    static let cellHeight = CGFloat(170)
    static let sectionFont = UIFontMetrics(forTextStyle: .body).scaledFont(for: UIFont.preferredFont(forTextStyle: .body).withSize(32.0))
}

extension String {
    func buildImageUrl(size: CGSize) -> URL {
        return URL(string: "http://127.0.0.1:1323/images/\(self)/\(Int(size.width))x\(Int(size.height))/image.png")!
    }
}

class MenuViewController: UIViewController, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    @IBOutlet weak var menuDishesView: UICollectionView!
    @IBOutlet weak var menuDishesViewLayout: UICollectionViewFlowLayout!
    
    // MARK - Model
    private var menu : [ MenuCategory ] = [ MenuCategory(name: "Салаты", dishes: buildDishes()),
                                                  MenuCategory(name: "Супы", dishes: buildDishes()),
                                                  MenuCategory(name: "Горячие закуски", dishes: buildDishes()),
                                                  MenuCategory(name: "Гарниры", dishes: buildDishes()),
                                                  MenuCategory(name: "Рыба и морепродукты", dishes: buildDishes()) ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupMenuDishesView()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? MenuCategoriesViewController, segue.identifier == "MenuCategorySegue" {
            vc.menu = self.menu
        }
    }
    
    // MARK - Menu Dishes View
    
    private func setupMenuDishesView() {
        menuDishesView.delegate = self
        menuDishesView.dataSource = self
        
        menuDishesViewLayout.itemSize = CGSize(width: menuDishesView.bounds.width, height: DishesViewConstant.cellHeight)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return menu.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menu[section].dishes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = menuDishesView.dequeueReusableCell(withReuseIdentifier: "DishCell", for: indexPath)
        if let dishesCell = cell as? DishesViewCell {
            if let imageName = menu[indexPath.section].dishes[indexPath.row].imageName {
                let imageUrl = imageName.buildImageUrl(size: dishesCell.imageView.bounds.size)
                DispatchQueue.global(qos: .userInitiated).async { [weak dishesCell] in
                    do {
                        let urlData = try Data(contentsOf: imageUrl)
                        DispatchQueue.main.async {
                            //if let imageData = urlData {
                                //dishesCell?.imageView.image = UIImage(data: urlData)
                            dishesCell?.imageView.
                            //}
                        }
                    } catch {
                        print("error:\(error)")
                    }
                }
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let cell = menuDishesView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "CategorySection", for: indexPath)
        if let categoryCell = cell as? CategorySectionViewCell {
            categoryCell.label.text = menu[indexPath.section].name
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        let height = DishesViewConstant.sectionFont.lineHeight
        let name = menu[section].name
        let width = NSAttributedString(string: name,
                                       attributes: [.font: DishesViewConstant.sectionFont]).width(withConstrainedHeight: height)
        
        return CGSize(width: width, height: height)
    }
    
}

