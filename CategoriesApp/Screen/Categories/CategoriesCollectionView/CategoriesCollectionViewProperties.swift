//
//  CategoriesCollectionViewFeatures.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import UIKit

protocol CategoriesOutput: AnyObject {
    func getHeight() -> CGFloat
    func didSelectItem(categoryId: String?, filter: String?)
}

class CategoriesCollectionViewProperties: NSObject {
    
    // MARK: Properties
    
    private var categories: [Categories] = []
    weak var delegate: CategoriesOutput?
    
    // MARK: Func
    
    func update(categories: [Categories]) {
        self.categories = categories
    }
}

// MARK: Extensions

extension CategoriesCollectionViewProperties: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Identifier.CATEGORY_CELL,
            for: indexPath) as? CategoriesCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureName(category: categories[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectItem(categoryId: categories[indexPath.item].categoryID, filter: "")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let colums: CGFloat = 1
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height = (delegate?.getHeight() ?? 300.0) / 10
        return CGSize(width: width, height: height)
    }
}
