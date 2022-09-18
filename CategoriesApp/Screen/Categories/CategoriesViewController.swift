//
//  ViewController.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import UIKit
import SnapKit

final class CategoriesViewController: UIViewController {
    
    // MARK: View
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifier.CATEGORY_CELL)
        return collectionView
    }()
    
    // MARK: Properties
    
    private var viewModel: CategoriesViewModelProtocol?
    private var collectionViewProperties: CategoriesCollectionViewProperties?
    private var productsCollectionViewProperties: ProductsCollectionViewProperties?
    
    // MARK: Init
    
    init(viewModel: CategoriesViewModelProtocol,
         collectionViewProperties: CategoriesCollectionViewProperties) {
        self.viewModel = viewModel
        self.collectionViewProperties = collectionViewProperties
        
        super.init(nibName: nil, bundle: nil)
    }
 
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Categories"
        
        indicator.startAnimating()
        collectionView.isHidden = true
        
        viewModel?.output = self
        viewModel?.fetchCategories()
        
        setUpDelegate()
        setUpView()
    }
    
    // MARK: Func
    
    func setUpDelegate() {
        
        collectionView.delegate = collectionViewProperties
        collectionView.dataSource = collectionViewProperties
        
        collectionViewProperties?.delegate = self
    }

    func setUpView() {
        
        view.backgroundColor = .white
        view.addSubview(indicator)
        view.addSubview(collectionView)
        
        setUpConstraint()
    }
    
    func setUpConstraint() {
        
        indicator.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.centerY.equalTo(view.snp.centerY)
            make.height.equalTo(50)
            make.width.equalTo(50)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(5)
            make.right.equalTo(view).offset(-5)
            make.bottom.equalTo(view.snp.bottom).offset(-5)
            make.centerX.equalTo(view.snp.centerX)
        }
    }
}

// MARK: Extensions

extension CategoriesViewController: CategoriesOutput {
   
    func getHeight() -> CGFloat {
        return view.bounds.height
    }
    
    func didSelectItem(categoryId: String?, filter: String?) {
        navigationController?.pushViewController(ProductsViewBuilder.build(categoryId: categoryId, filter: filter), animated: true)
    }
}

extension CategoriesViewController: CategoriesViewModelOutput {
    func updateData(categories: [Categories]) {
        collectionViewProperties?.update(categories: categories)
        collectionView.reloadData()
        indicator.stopAnimating()
        collectionView.isHidden = false
    }
}

