//
//  ProductsCollectionViewProperties.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import UIKit

protocol ProductsOutput: AnyObject {
    
    func didSelectProduct(productId: String?)
}

class ProductsCollectionViewProperties: NSObject {
    
    // MARK: Properties
    
    var products: [Products] = []
    weak var delegate: CategoriesOutput?
    weak var productDelegate: ProductsOutput?
    
    func update(products: [Products]) {
        self.products = products
    }

}

// MARK: Extensions

extension ProductsCollectionViewProperties: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.Identifier.PRODUCT_CELL,
            for: indexPath) as? ProductsCollectionViewCell
        else { return UICollectionViewCell() }
        cell.configureProducts(products: products[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        productDelegate?.didSelectProduct(productId: products[indexPath.item].id)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let colums: CGFloat = 2
        let collectioViewWith = collectionView.bounds.width
        let flowLayout = collectionViewLayout as! UICollectionViewFlowLayout
        let spaceBetweenCells = flowLayout.minimumInteritemSpacing * (colums - 1)
        let adjustedWith = collectioViewWith - spaceBetweenCells
        let width: CGFloat = floor(adjustedWith / colums)
        let height = (delegate?.getHeight() ?? 300.0) / 1.3
        return CGSize(width: width, height: height)
    }
}
