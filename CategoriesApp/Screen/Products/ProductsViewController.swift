//
//  ProductsViewController.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import UIKit
import DropDown

class ProductsViewController: UIViewController {
    
    // MARK: View
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let noResult: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifier.PRODUCT_CELL)
        return collectionView
    }()
    
    private let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = ["Price",
                           "Title",
                           "PublishmentDate"]
        return menu
    }()
    
    // MARK: Properties
    
    private var productsCollectionViewProperties: ProductsCollectionViewProperties?
    private var viewModel: ProductsViewModelProtocol?
    
    // MARK: Init
    
    init(viewModel: ProductsViewModelProtocol,
         productsCollectionViewProperties: ProductsCollectionViewProperties) {
        self.viewModel = viewModel
        self.productsCollectionViewProperties = productsCollectionViewProperties
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        collectionView.isHidden = true
        noResult.isHidden = true
        
        let filter = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = filter
        
        menu.anchorView = filter
        
        setUpDelegate()
        setUpView()
    }
    
    func setUpDelegate() {
        collectionView.delegate = productsCollectionViewProperties
        collectionView.dataSource = productsCollectionViewProperties
        
        productsCollectionViewProperties?.productDelegate = self
        viewModel?.output = self
    }

    func setUpView() {
        view.backgroundColor = .white
        view.addSubview(indicator)
        view.addSubview(noResult)
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
            indicator.widthAnchor.constraint(equalToConstant: 50),
            
            noResult.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            noResult.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            noResult.heightAnchor.constraint(equalToConstant: 50),
            noResult.widthAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    @objc func addTapped() {
        menu.show()
        
        menu.selectionAction = { index, title in
            let filterTitle = title
            let filterId = self.viewModel?.filterId
            self.viewModel?.fetchProducts(id: filterId, filter: filterTitle)
            self.indicator.startAnimating()
            self.collectionView.isHidden = true
        }
    }
}

// MARK: Extensions

extension ProductsViewController: ProductsOutput {
    func didSelectProduct(productId: String?) {
        navigationController?.pushViewController(DetailViewBuilder.build(productId: productId), animated: true)
    }
}

extension ProductsViewController: ProductsViewModelOutput {
   
    func selectCategory(products: [Products]) {
        productsCollectionViewProperties?.update(products: products)
        collectionView.reloadData()
        indicator.stopAnimating()
        collectionView.isHidden = false
    }
    
    func noResults() {
        indicator.stopAnimating()
        noResult.isHidden = false
        collectionView.isHidden = true
        noResult.text = "Data Not Found"
    }
}

