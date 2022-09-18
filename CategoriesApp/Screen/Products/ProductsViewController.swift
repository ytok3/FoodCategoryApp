//
//  ProductsViewController.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 10.09.2022.
//

import UIKit
import DropDown
import SnapKit

class ProductsViewController: UIViewController {
    
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
        collectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: Constants.Identifier.PRODUCT_CELL)
        return collectionView
    }()
    
    private let menu: DropDown = {
        let menu = DropDown()
        menu.dataSource = [Constants.Properties.Filter_Price,
                           Constants.Properties.Filter_Title,
                           Constants.Properties.Filter_Publishment_Date]
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
        
        let filter = UIBarButtonItem(title: Constants.Properties.Filter, style: .plain, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItem = filter
        
        menu.anchorView = filter
        
        setUpDelegate()
        setUpView()
    }
    
    // MARK: Func
    
    func setUpDelegate() {
        
        collectionView.delegate = productsCollectionViewProperties
        collectionView.dataSource = productsCollectionViewProperties
        
        productsCollectionViewProperties?.productDelegate = self
        viewModel?.output = self
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
}

