//
//  ProductDetailViewController.swift
//  CategoriesApp
//
//  Created by Yasemin TOK on 11.09.2022.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: View
    
    private let indicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
        indicator.color = .black
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private let productImage: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleToFill
        iv.clipsToBounds = true
        iv.backgroundColor = .white
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let verticalStack: UIStackView = {
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.distribution = .equalSpacing
        sv.axis = .vertical
        return sv
    }()
    
    private let titleName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 25)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let campaignPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private let productDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private var addButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.clipsToBounds = true
        button.setTitle("ADD TO BASKET", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 4
        return button
    }()
    
    // MARK: Properties
    
    private var  viewModel: DetailViewModel?
    
    // MARK: Init
    
    init(viewModel: DetailViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
 
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicator.startAnimating()
        activeIndicator()
  
        viewModel?.output = self
        
        setUpView()
        setUpConstraint()
    }

    // MARK: Func
    
    func activeIndicator() {
        productImage.isHidden = true
        verticalStack.isHidden = true
        addButton.isHidden = true
    }
    
    func passiveIndicator() {
        productImage.isHidden = false
        verticalStack.isHidden = false
        addButton.isHidden = false
    }
    
    func setUpView() {
        
        view.backgroundColor = .white
        view.addSubview(indicator)
        view.addSubview(productImage)
        view.addSubview(verticalStack)
        verticalStack.addArrangedSubview(titleName)
        verticalStack.addArrangedSubview(price)
        verticalStack.addArrangedSubview(campaignPrice)
        verticalStack.addArrangedSubview(productDescription)
        view.addSubview(addButton)
    }
    
    func configureProduct(product: Detail) {
        
        self.productImage.af.setImage(withURL: URL(string: (product.featuredImage?.t)!)!)
        self.titleName.text = product.title
        self.price.text = Constants.Properties.Price + "\(product.price!)"
        
        if product.campaignPrice == nil {
            campaignPrice.removeFromSuperview()
        } else {
            self.campaignPrice.text = Constants.Properties.Campaing_Price + "\(product.campaignPrice ?? 0)"
        }
        
        self.productDescription.text = product.dataDescription
    
    }
    
    
    private func setUpConstraint() {
        
        let padding: CGFloat = 4
        
        NSLayoutConstraint.activate([
            
            productImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: padding),
            productImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            productImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            productImage.heightAnchor.constraint(equalToConstant: view.frame.height / 2 ),
            productImage.widthAnchor.constraint(equalToConstant: view.frame.width),
            
            verticalStack.topAnchor.constraint(equalTo: productImage.bottomAnchor, constant: padding),
            verticalStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            verticalStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            titleName.topAnchor.constraint(equalTo: verticalStack.topAnchor, constant: padding),
            titleName.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            
            price.topAnchor.constraint(equalTo: titleName.bottomAnchor, constant: padding),
            price.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            
            campaignPrice.topAnchor.constraint(equalTo: price.bottomAnchor, constant: padding),
            campaignPrice.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            
            productDescription.topAnchor.constraint(equalTo: price.bottomAnchor, constant: padding),
            productDescription.heightAnchor.constraint(equalToConstant: view.frame.height / 20),
            
            addButton.topAnchor.constraint(equalTo: verticalStack.bottomAnchor, constant: padding * 5),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            addButton.heightAnchor.constraint(equalToConstant: view.frame.height / 15),
            addButton.widthAnchor.constraint(equalToConstant: view.frame.width / 2),
            addButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding * 10),
            
            indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 50),
            indicator.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
}

// MARK: Extension

extension DetailViewController: DetailViewModelOutput {
    func selectProduct(product: Detail?) {
        configureProduct(product: product!)
        indicator.stopAnimating()
        passiveIndicator()
    }
}
