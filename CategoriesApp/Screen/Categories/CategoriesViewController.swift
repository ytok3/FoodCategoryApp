//
//  ViewController.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 9.09.2022.
//

import UIKit

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
    
    private func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 50),
            indicator.widthAnchor.constraint(equalToConstant: 50)
        ])
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

